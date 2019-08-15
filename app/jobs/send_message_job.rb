class SendMessageJob < ActiveJob::Base
  queue_as :default

  def perform(uid, total)
  	customization = YAML.load_file("config/customization.yml")
    user = customization[:user]
    password = customization[:password]
    post_data = {'recipient_id'=> uid, 'user' => user, 'password' => password, 'elements' => total }.to_json
    uri = URI.parse(customization[:user_message_post])
    https = Net::HTTP.new(uri.host,uri.port)
    # https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req.body = post_data
    res = https.request(req)
    File.open("#{Rails.root}/log/mm.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601}: #{uid} \n---------------------------------------------\n\n))
      file.syswrite(%(#{Time.now.iso8601}: #{uri} \n---------------------------------------------\n\n))
      file.syswrite(%(#{Time.now.iso8601}: #{post_data} \n---------------------------------------------\n\n))
      file.syswrite(%(#{Time.now.iso8601}: #{res.body} \n---------------------------------------------\n\n))
    end
    p "send #{Time.now}"
  end
end
