class PostMessageApiJob < ActiveJob::Base
  queue_as :default
  
  def perform(*args)
    mp = MessagePush.find_by(:delayed_job_id => self.job_id)
    customization = YAML.load_file("config/customization.yml")
    case mp.purpose
    when "1"
      uri = URI.parse(customization[:farmer_survey])
    when "2"
      uri = URI.parse(customization[:user_survey])
    when "3"
      uri = URI.parse(customization[:t_farmer_survey])
    when "4"
      uri = URI.parse(customization[:t_user_survey])
    end
    user = customization[:user]
    password = customization[:password]
    total = 0
    mp.group.group_user_ships.each do |group|
      user_rec = UserAnalyze.create(:uid => group.uid, :pl => mp.module_name)
      gg = []
      gg << group.uid
      post_data = {'recipient_ids'=> gg, 'user' => user, 'password' => password, 'name' => mp.module_name }.to_json
      https = Net::HTTP.new(uri.host,uri.port)
      # https.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
      req.body = post_data
      res = https.request(req)
      File.open("#{Rails.root}/log/mm.log", "a+") do |file|
        file.syswrite(%(#{Time.now.iso8601}: #{gg} \n---------------------------------------------\n\n))
        file.syswrite(%(#{Time.now.iso8601}: #{post_data} \n---------------------------------------------\n\n))
        file.syswrite(%(#{Time.now.iso8601}: #{res.body} \n---------------------------------------------\n\n))
        file.syswrite(%(#{Time.now.iso8601}: NEW \n---------------------------------------------\n\n))
      end
      res_body = JSON res.body
      total += 1 if res_body["Count"].to_i == 1
    end
    mp.complete_time = Time.now
    mp.total_number = total
    mp.save!

    # group = mp.group.group_user_ships.map { |group| group.uid } 
    # post_data = {'recipient_ids'=> group, 'user' => user, 'password' => password, 'name' => mp.module_name }.to_json
    # https = Net::HTTP.new(uri.host,uri.port)
    # https.use_ssl = true
    # req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    # req.body = post_data
    # res = https.request(req)
    # File.open("#{Rails.root}/log/mm.log", "a+") do |file|
    #   file.syswrite(%(#{Time.now.iso8601}: #{group} \n---------------------------------------------\n\n))
    #   file.syswrite(%(#{Time.now.iso8601}: #{post_data} \n---------------------------------------------\n\n))
    #   file.syswrite(%(#{Time.now.iso8601}: #{res.body} \n---------------------------------------------\n\n))
    # end
    # mp.complete_time = Time.now
    # res_body = JSON res.body[1..-2].gsub('\\', '')
    # a = 0
    # res_body["Results"].each_with_index do |rr, i|
    #   b = i + 1
    #   a+=1 if rr["#{b}"][0]["message_id"].present?
    # end
    # mp.delivery_number = a
    # mp.total_number = res_body["Count"].to_i
    # mp.save!
  end
end
