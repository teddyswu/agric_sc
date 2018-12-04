class PostMessageApiJob < ActiveJob::Base
  queue_as :default
  
  def perform(*args)
    mp = MessagePush.find_by(:delayed_job_id => self.job_id)
    mo = Wording.where("name like '%#{mp.module_name}%'").order(:name)
    message = Array.new
    mo.each do |m|
      message << JSON.parse(m.content)
    end
    customization = YAML.load_file("config/customization.yml")
    uri = URI.parse(customization[:user_message_post])
    user = customization[:user]
    password = customization[:password]
    mp.group.group_user_ships.each do |group|
      post_data = {'recepient_id'=> group.uid, 'user' => user, 'password' => password, 'elements' => message }.to_json
      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
      req.body = post_data
      res = https.request(req)
      File.open("#{Rails.root}/log/mm.log", "a+") do |file|
        file.syswrite(%(#{Time.now.iso8601}: #{group.uid} \n---------------------------------------------\n\n))
        file.syswrite(%(#{Time.now.iso8601}: #{post_data} \n---------------------------------------------\n\n))
        file.syswrite(%(#{Time.now.iso8601}: #{res.body} \n---------------------------------------------\n\n))
      end
    end
    mp.complete_time = Time.now
    mp.save!
  end
end
