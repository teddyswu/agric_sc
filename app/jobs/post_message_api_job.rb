class PostMessageApiJob < ActiveJob::Base
  queue_as :default
  
  def perform(*args)
    mp = MessagePush.find_by(:delayed_job_id => self.job_id)
    customization = YAML.load_file("config/customization.yml")
    uri = (mp.purpose == 1 ? URI.parse(customization[:farmer_survey]) : URI.parse(customization[:user_survey]))
    user = customization[:user]
    password = customization[:password]
    group = mp.group.group_user_ships.map { |group| group.uid } 
    post_data = {'recipient_ids'=> group, 'user' => user, 'password' => password, 'name' => mp.module_name }.to_json
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
    res_body = JSON res.body#[1..-2].gsub('\\', '')
    a = 0
    res_body["Results"].each_with_index do |rr, i|
      b = i + 1
      a+=1 if rr["#{b}"][0]["message_id"].present?
    end
    mp.delivery_number = a
    mp.total_number = res_body["Count"].to_i
    mp.save!
  end
end
