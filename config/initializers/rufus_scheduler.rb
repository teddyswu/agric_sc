# -*- encoding : utf-8 -*-
require 'net/http'
# include ToolsLibrary

def safely_and_compute_time
  beginning = Time.now
  # 用來解決資料庫 rufus_scheduler 連線 db 結束時, 不會中斷連線
  unless ActiveRecord::Base.connected?
    ActiveRecord::Base.connection.verify!(0)
  end
  message = yield
  spent   = Time.now - beginning
  SogiBuilder::CustomizedLog.write("jobs.log", "Time Spent:#{spent}, #{message}")
rescue Exception => e
  SogiBuilder::CustomizedLog.write("jobs.log", e.inspect)
ensure
  # 不管發生任何事, 最後 db 連線一定要清除到限制以內
  ActiveRecord::Base.connection_pool.release_connection
end

scheduler  = Rufus::Scheduler.start_new
proc_mutex = Mutex.new # 初始化一個 process 鎖  

scheduler.cron '00 02 * * *', :mutex => proc_mutex do
  safely_and_compute_time do  
    ua = UserAnalyze.where(:pl => nil, :ref => nil).where("created_at < ?", Date.today - 1.day).where.not(:watermarks => nil, :status => nil)
    ua.destroy_all
  end
end

scheduler.cron '00 03 * * *', :mutex => proc_mutex do
  safely_and_compute_time do  
    ups = UserProfile.where.not(:birthday => nil)
    now = Time.now.utc.to_date
    ups.each do |up|
      dob = up.birthday
      user_age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
      case user_age
        when 0..19
          then up.age_range = 1
        when 20..29
          then up.age_range = 2
        when 30..39
          then up.age_range = 3
        when 40..49
          then up.age_range = 4
        when 50..59
          then up.age_range = 5
        else 
          up.age_range = 6
      end
      up.save!
    end
  end
end