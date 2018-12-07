class PostMessageApiJob < ActiveJob::Base
  queue_as :default
  
  def perform(*args)
    mp = MessagePush.find_by(:delayed_job_id => self.job_id)
    customization = YAML.load_file("config/customization.yml")
    uri = URI.parse(customization[:survey])
    user = customization[:user]
    password = customization[:password]
    group = mp.group.group_user_ships.map { |group| group.uid } 
    post_data = {'recepient_ids'=> group, 'user' => user, 'password' => password, 'name' => mp.module_name }.to_json
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req.body = post_data
    res = https.request(req)
    File.open("#{Rails.root}/log/mm.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601}: #{group} \n---------------------------------------------\n\n))
      file.syswrite(%(#{Time.now.iso8601}: #{post_data} \n---------------------------------------------\n\n))
      file.syswrite(%(#{Time.now.iso8601}: #{res.body} \n---------------------------------------------\n\n))
    end
    mp.complete_time = Time.now
    mp.save!
  end
end
