# -*- encoding : utf-8 -*-
class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(*providers)
    providers.each do |provider|
      class_eval %Q{
        def #{provider}
          User.transaction do
            if !current_user.blank?
              binding_ip = request.remote_ip + request.env["HTTP_USER_AGENT"]
              aa = FbBinding.find_by_binding_ip(binding_ip)
              if aa.present?
                Authorization.find_or_create_by(:provider => "facebook", :uid => aa.scoped_id, :user_id => current_user.id)
                FbBinding.destroy_all(:binding_ip => binding_ip)
                first_start(aa.scoped_id, aa.module_name)
                render partial: "shared/fb"
              else
                current_user.bind_service(env["omniauth.auth"])#Add an auth to existing
                redirect_to root_path(), :notice => "Bind #{provider} account successfully."
              end
            else
              @user = User.find_or_create_for_#{provider}(env["omniauth.auth"])
              if @user == nil
                render :text => "<script>alert('登入失敗，請檢查您的Facebook是否有電子郵件資料，並同意授權我們作為會員帳號使用，謝謝!');location.href='/footers/fb_faq';</script>" and return
              end
              if @user.persisted? 
                binding_ip = request.remote_ip + request.env["HTTP_USER_AGENT"]
                aa = FbBinding.find_by_binding_ip(binding_ip)
                if aa.present?
                  Authorization.create(:provider => "facebook", :uid => aa.scoped_id, :user_id => @user.id)
                  FbBinding.destroy_all(:binding_ip => binding_ip)
                  sign_in @user
                  first_start(aa.scoped_id, aa.module_name)
                  render partial: "shared/fb"
                else
                  sign_in_and_redirect @user, :event => :authentication
                end
              else
                redirect_to new_user_registration_url
              end
            end
          end # transaction
        end
      }
    end
  end
  
  # 原第13行
  # sign_in_and_redirect @user, :event => :authentication, :notice => "Signed in successfully."

  provides_callback_for :facebook, :tqq , :weibo, :twitter, :yahoo, :google, :qq_connect

  # This is solution for existing accout want bind Google login but current_user is always nil
  # https://github.com/intridea/omniauth/issues/185
  def handle_unverified_request
    true
  end

  def first_start(scoped_id, module_name)
    @root_domain = YAML.load_file("config/customization.yml")[:root_domain]
    @project_domain = YAML.load_file("config/customization.yml")[:campaign_domain]
    if module_name != nil
      word = ParameterJson.where("name like ? and parameter_set_type = ?", "%#{module_name}%","subscribe_guest")
      total = JSON.parse(word.first.json.gsub("=>", ":"))
    else
      auth = Authorization.find_by_uid(scoped_id)
      total = Array.new
      text = Array.new
      text_a = Array.new
      text_1 = Hash.new
      if auth.user.orders.size > 0
        text_1["NAME"] = "TEAFU.MENU.B2C.05.01"
        text_1["type"] = "text"
        text_1["text"] = "#{params[:n]}您好，這是您支持中的提案："
        text_1["delay"] = 1
        text << text_1
        auth.user.orders.order(:paid).limit(10).each_with_index do |order, i|
          if order.goody.campaign.end_date > Date.today
            remain_day = (order.goody.campaign.end_date - Date.today).to_i
            amount_raised = order.goody.campaign.amount_raised
            percentage = 100*(amount_raised.to_f / order.goody.campaign.goal)
            text_2_c = Hash.new
            text_2_c["NAME"] = "ugooz.b2c.menulist.mb1.01.02.0#{i}"
            text_2_c["title"] = order.goody.campaign.title
            text_2_c["subtitle"] = "剩餘時間: #{remain_day}天\n目前達成: #{percentage}%\n回饋項目: #{order.goody.title}\n預計寄送: #{order.goody.delivery_time}"
            text_2_c["image_url"] = order.goody.campaign.campaign_image.campaign_path
            buttons = Array.new #[]
            t1 = Hash.new
            if order.paid == false
              t1["type"] = "web_url"
              t1["title"] = "付款去"
              t1["url"] = "#{@project_domain}/orders/#{order.id}/go_pay"
            else
              t1["type"] = "web_url"
              t1["title"] = "查看詳細記錄"
              t1["url"] = "#{@project_domain}/orders/#{order.id}/detail"
            end
            buttons << t1
            t2 = Hash.new
            t2["type"] = "web_url"
            t2["title"] = "查看最新進度"
            t2["url"] = "#{@project_domain}/campaigns/#{order.goody.campaign.slug}/updates"
            buttons << t2
            text_2_c["buttons"] = buttons 
            text_a << text_2_c
          end
        end
        total << text
        total << text_a
      else
        text_1["name"] = "TEAFU.MENU.B2C.05.01"
        text_1["type"] = "text"
        text_1["text"] = I18n.t("proposal.thanks_for_subscription")
        text_1["delay"] = 1
        text << text_1
        text_2 = Hash.new
        text_2["name"] = "TEAFU.MENU.B2C.05.02"
        text_2["type"] = "text"
        text_2["text"] = I18n.t("proposal.no_upport_proposal")
        text_2["delay"] = 1
        text << text_2
        total << text
        card = Array.new
        campaigns = Campaign.where("status = 3 and start_date < ? and end_date > ?",Date.today,Date.today).limit(10)
        campaigns.each do |campaign|
          remain_day = (campaign.end_date - Date.today).to_i
          amount_raised = campaign.amount_raised
          percentage = 100*(amount_raised.to_f / campaign.goal)
          description = campaign.description.first(40)
          text_a = Hash.new
          text_a["title"] = campaign.title
          text_a["subtitle"] = "#{description}\n\n剩餘時間: #{remain_day}天\n目前達成: #{percentage}%\n支持人數: #{campaign.orders.is_paid.size}人"
          text_a["image_url"] = campaign.campaign_image.campaign_path
          buttons = Array.new #[]
          t1 = Hash.new
          t1["type"] = "web_url"
          t1["title"] = "追蹤♥"
          t1["url"] = "#{@root_domain}/data_connects/story?motion=get&type=fb_track&scoped_id=[[RECIPIENT_ID]]&slug=#{campaign.slug}"
          buttons << t1
          t2 = Hash.new
          t2["type"] = "web_url"
          t2["title"] = "查看內容"
          t2["url"] = "#{@project_domain}/campaigns/#{campaign.slug}"
          buttons << t2
          text_a["buttons"] = buttons
          card << text_a
        end
        total << card
      end
    end
    SendMessageJob.set(wait: 0.seconds).perform_later(scoped_id, total)
    # customization = YAML.load_file("config/customization.yml")
    # uri = URI.parse(customization[:user_message_post])
    # user = customization[:user]
    # password = customization[:password]
    # post_data = {'recipient_id'=> scoped_id, 'user' => user, 'password' => password, 'elements' => total }.to_json
    # https = Net::HTTP.new(uri.host,uri.port)
    # # https.use_ssl = true
    # req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    # req.body = post_data
    # res = https.request(req)
    # File.open("#{Rails.root}/log/mm.log", "a+") do |file|
    #   file.syswrite(%(#{Time.now.iso8601}: #{scoped_id} \n---------------------------------------------\n\n))
    #   file.syswrite(%(#{Time.now.iso8601}: #{uri} \n---------------------------------------------\n\n))
    #   file.syswrite(%(#{Time.now.iso8601}: #{post_data} \n---------------------------------------------\n\n))
    #   file.syswrite(%(#{Time.now.iso8601}: #{res.body} \n---------------------------------------------\n\n))
    # end
  end


end
