class PostMessageApiJob < ActiveJob::Base
  queue_as :default
  
  def perform(*args)
    # Do something later
    
    customization = YAML.load_file("config/customization.yml")
    card = Array.new
    uri = URI.parse(customization[:user_message_post])
    user = customization[:user]
    password = customization[:password]
    post_data = {'recepient_id'=> params[:scoped_id], 'user' => user, 'password' => password, 'elements' => card }.to_json
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req.body = post_data
    res = https.request(req)
    File.open("#{Rails.root}/log/mm.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601}: #{params[:scoped_id]} \n---------------------------------------------\n\n))
      file.syswrite(%(#{Time.now.iso8601}: #{total} \n---------------------------------------------\n\n))
      file.syswrite(%(#{Time.now.iso8601}: #{res.body} \n---------------------------------------------\n\n))
    end
    pp = MessagePush.find_by(:delayed_job_id => self.job_id)
    pp.complete_time = Time.now
    pp.save!
  end
end
