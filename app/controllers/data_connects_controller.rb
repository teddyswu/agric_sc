class DataConnectsController < ApplicationController
	skip_before_action :verify_authenticity_token
  include ActionView::Helpers::NumberHelper
	def story
    @root_domain = YAML.load_file("config/customization.yml")[:root_domain]
    @project_domain = YAML.load_file("config/customization.yml")[:campaign_domain]
		case params[:motion]
		when "new"
			case params[:type]
			when "type_article"
				type_article = TypeArticle.new
				type_article.web_url = params[:web_url]
				type_article.content = params[:content]
				type_article.description = params[:description]
				type_article.save!
				resource = DigitalResourceShip.new
				resource.resource_type = "TypeArticle"
				resource.resource_id = type_article.id
				resource.title = params[:title]
				resource.encryption = "ss"
				resource.save!
				render json: "[{'encryption':" + "#{resource.encryption}" + "},{'status':'create ok'}]" and return
			when "type_gif"
				type_gif = TypeGif.new
				type_gif.url = params[:url]
				type_gif.file = "api"
				type_gif.save!
				resource = DigitalResourceShip.new
				resource.resource_type = "TypeGif"
				resource.resource_id = type_gif.id
				resource.title = "gif"
				resource.encryption = "ss"
				resource.save!
				render json: "[{'encryption':" + "#{resource.encryption}" + "},{'status':'create ok'}]" and return
			when "type_movie"
				type_movie = TypeMovie.new
				type_movie.pic_url = params[:pic_url]
				type_movie.movie_url = params[:movie_url]
				type_movie.description = params[:description]
				type_movie.save!
				resource = DigitalResourceShip.new
				resource.resource_type = "TypeMovie"
				resource.resource_id = type_movie.id
				resource.title = params[:title]
				resource.encryption = "ss"
				resource.save!
				render json: "[{'encryption':" + "#{resource.encryption}" + "},{'status':'create ok'}]" and return
			when "type_comic"
				type_comic = TypeComic.new
				type_comic.web_url = params[:web_url]
				type_comic.pic_1_url = params[:pic_1_url]
				type_comic.pic_2_url = params[:pic_2_url]
				type_comic.pic_3_url = params[:pic_3_url]
				type_comic.pic_4_url = params[:pic_4_url]
				type_comic.save!
				resource = DigitalResourceShip.new
				resource.resource_type = "TypeComic"
				resource.resource_id = type_comic.id
				resource.title = params[:title]
				resource.encryption = "ss"
				resource.save!
				render json: "[{'encryption':" + "#{resource.encryption}" + "},{'status':'create ok'}]" and return
			when "user_datum"
				user = User.find_by_encryption(params[:encryption])
				user_datum = UserDatum.new
				user_datum.user_id = user.id
				user_datum.user_data = params[:user_data]
				user_datum.file_type = params[:file_type]
				user_datum.save!
				render json: "[{'encryption':" + "#{user.encryption}" + "},{'status':'create ok'}]" and return
    	when "farmer"
    		check_uid = FarmerProfile.find_by_fb_uid(params[:uid])
    		if check_uid.blank?
    			user = User.new
    			user.email = "#{Time.now.to_i}@temp.com.tw"
    			user.password = "user_temp"
		    	user.encrypted_password = "user_temp"
		    	user.is_farmer = true
		    	user.save!
          user_profile = FarmerProfile.new
          user_profile.user_id = user.id
          user_profile.fb_uid = params[:uid]
          user_profile.name = params[:name]
          user_profile.cell_phone = params[:cell_phone]
          user_profile.pic_url = params[:profile_pic]
          user_profile.certificate_photo = params[:certificate]
          user_profile.certificate_photo_2 = params[:certificate_2]
          user_profile.save!
          render json: "[{'encryption':" + "#{user.encryption}" + "},{'status':'farmer create ok'}]" and return
    		else
    			render json: "[{'uid':" + "#{params[:uid]}" + "},{'status':'uid already exists'}]" and return
    		end
      when "work_diary"
        File.open("#{Rails.root}/log/diary.log", "a+") do |file|
          file.syswrite(%(#{Time.now.iso8601}: #{params} \n---------------------------------------------\n\n))
        end
        up = FarmerProfile.find_by_name(params[:name])
        if params[:photo] == nil
          wd = WorkDiary.where(:owner_id => up.user_id, :comment => "multi_upload").last
          wd.comment = params[:comment]
          wd.save!
        else
          wd = WorkDiary.new
          wd.owner_id = up.user_id
          wd.comment = params[:comment]
          wd.diary_time = Time.now
          wd.save!
          File.open("#{Rails.root}/log/diary.log", "a+") do |file|
            file.syswrite(%(#{Time.now.iso8601}: #{params[:photo].class.to_s} \n---------------------------------------------\n\n))
          end
          if params[:photo].class.to_s == "Array"
            params[:photo].each do |v|
              fb_to_aw = Hash.new
              fb_to_aw["remote_file_url"] = v
              aa = FbToAw.new(fb_to_aw)
              aa.save!
              aa.update_urls_success?
              wd.work_diary_images.create( :url => v, :cover_url => aa.cover_url, :origin_url => aa.origin_url, :show_url => aa.show_url, :enabled => true )
            end
          else
            fb_to_aw = Hash.new
            fb_to_aw["remote_file_url"] = params[:photo]
            aa = FbToAw.new(fb_to_aw)
            aa.save!
            aa.update_urls_success?
            wd.work_diary_images.create( :url => params[:photo], :cover_url => aa.cover_url, :origin_url => aa.origin_url, :show_url => aa.show_url, :enabled => true )
          end
        end
        render json: "[{" + '"status":"work_diary create ok"' + "}]" and return
    	when "work_record"
        File.open("#{Rails.root}/log/record.log", "a+") do |file|
          file.syswrite(%(#{Time.now.iso8601}: #{params} \n---------------------------------------------\n\n))
        end
    		wr = WorkRecordLog.new
        up = FarmerProfile.find_by_name(params[:name])
    		wr.owner_id = up.user_id
    		wr.record_type = params[:record_type]
    		wr.farming_category = params[:farming_category]
    		wr.filed_code = params[:filed_code]
    		wr.work_project = params[:work_project]
        wr.work_time = Time.now
    		wr.weight = params[:weight]
    		wr.save!
        if params[:filed_code] != "X"
          wr_t = WorkRecord.new
          wr_t.owner_id = up.user_id
          wr_t.record_type = ( WorkProject.find_by_name(params[:work_project]).present? ? WorkProject.find_by_name(params[:work_project]).record_type : 0 )
          wr_t.farming_category = wr.farming_category
          wr_t.filed_code = wr.filed_code
          wr_t.work_project = wr.work_project
          wr_t.work_time = wr.created_at
          wr_t.weight = wr.weight
          wr_t.save!
        end
    		render json: "[{" + '"status":"work_record create ok"' + "}]" and return
      when "behavior"
        ub = UserBehavior.new
        ub.name = params[:name]
        ub.scoped_id = params[:scoped_id]
        ub.payload = params[:payload]
        ub.save!
        render json: "[{" + '"status":"activity create ok"' + "}]" and return
    	end
		when "delete"
			type = DigitalResourceShip.find_by_encryption(params[:encryption])
			type.resource.destroy
			type.destroy
			render json: "[{'encryption':" + "#{params[:encryption]}" + "},{'status':'delete ok'}]" and return
		when "edit"
			type_ship = DigitalResourceShip.find_by_encryption(params[:encryption])
			case type_ship.resource_type
			when "TypeArticle"
				type_ship.title = params[:title] if params[:title].present?
				type_ship.save!
				type_ship.resource.web_url = params[:web_url] if params[:web_url].present?
				type_ship.resource.content = params[:content] if params[:content].present?
				type_ship.resource.description = params[:description] if params[:description].present?
				type_ship.resource.save!
				render json: "[{'encryption':" + "#{params[:encryption]}" + "},{'status':'edit ok'}]" and return
			when "TypeGif"
				type_ship.title = params[:title] if params[:title].present?
				type_ship.save!
				type_ship.resource.url = params[:url] if params[:url].present?
				type_ship.resource.save!
				render json: "[{'encryption':" + "#{params[:encryption]}" + "},{'status':'edit ok'}]" and return
			when "TypeMovie"
				type_ship.title = params[:title] if params[:title].present?
				type_ship.save!
				type_ship.resource.pic_url = params[:pic_url] if params[:pic_url].present?
				type_ship.resource.movie_url = params[:movie_url] if params[:movie_url].present?
				type_ship.resource.description = params[:description] if params[:description].present?
				typetype_ship.resource_ship.save!
				render json: "[{'encryption':" + "#{params[:encryption]}" + "},{'status':'edit ok'}]" and return
			when "TypeComic"
				type_ship.title = params[:title] if params[:title].present?
				type_ship.save!
				type_ship.resource.web_url = params[:web_url] if params[:web_url].present?
				type_ship.resource.pic_1_url = params[:pic_1_url] if params[:pic_1_url].present?
				type_ship.resource.pic_2_url = params[:pic_2_url] if params[:pic_2_url].present?
				type_ship.resource.pic_3_url = params[:pic_3_url] if params[:pic_3_url].present?
				type_ship.resource.pic_4_url = params[:pic_4_url] if params[:pic_4_url].present?
				type_ship.resource.save!
				render json: "[{'encryption':" + "#{params[:encryption]}" + "},{'status':'edit ok'}]" and return
    	end
    when "user"
    	user = User.new
    	user.email = params[:email]
    	user.password = "user_temp"
    	user.encrypted_password = "user_temp"
    	user.save!
      render json: '[{"encryption":' + '"' + user.encryption + '"' + '},{"status":"user create ok"}]' and return
    when "user_datum"
    	user = User.find_by_encryption(params[:encryption])
    	render json: user.user_datums.select(:user_data,:id) and return
    when "check_farmer"
    	user_profile = FarmerProfile.find_by_name(params[:name])
    	if user_profile == nil
    		render json: '[{"check":false}]'
    	else
        if user_profile.user.is_check_farmer == true
        	render json: '[{"check":true}]'
        else
        	render json: '[{"check":false}]'
        end
    	end
    when "farmer_data"
    	user_profile = FarmerProfile.find_by_name(params[:name])
    	if user_profile == nil
    		render json: "[{'status':no data}]"
    	else
    		render json: '{"uid":"' + user_profile.fb_uid.to_s + '","name":"' + user_profile.name.to_s + '","front_name":"' + user_profile.front_name.to_s + '","cell_phone":"' + user_profile.cell_phone.to_s + '","certificate":"' + user_profile.certificate_photo.to_s + '","certificate_2":"' + user_profile.certificate_photo_2.to_s + '","profile_pic":"' + user_profile.pic_url.to_s + '","farmer_info":"' + "#{@root_domain}/farmers/#{user_profile.user_id}" + '","farmer_record":"' + "#{@root_domain}/farmers/#{user_profile.user_id}/work_record\"}"
      end
    when "edit_farmer_data"
  		user_profile = FarmerProfile.find_by_name(params[:name])
  		user_profile.cell_phone = params[:cell_phone] if params[:cell_phone].present?
  		user_profile.pic_url = params[:profile_pic] if params[:profile_pic].present?
  		user_profile.certificate_photo = params[:certificate] if params[:certificate].present?
  		user_profile.certificate_photo_2 = params[:certificate_2] if params[:certificate_2].present?
  		user_profile.save!
  		render json: "[{'update':ok}]"
  	when "delete_farmer_data"
  		user_profile = FarmerProfile.find_by_name(params[:name])
  		user_profile.destroy
  		render json: "[{'delete':ok}]"
    when "get"
    	case params[:type].downcase
    	when "filed_code"
	    	user = User.joins(:farmer_profile).where("farmer_profiles.name = ? and users.is_farmer = true and users.is_check_farmer = true", params[:name])
	    	filed_code = FiledCode.where(:user_id => user[0].id).order(:id)
		    filed = Array.new
		    filed_code.each do |code|
		    	filed << code.filed_code_name
		    end
	      render json: filed
    	when "before_farming_work"
    		work_projects = WorkProject.select(:name).where(:record_type => 1).map {|work| work.name }
        work = Array.new
        work_projects.each_slice(3) do |work_project|
        	work << work_project
        end
        render json: work
      when "after_farming_work"
      	work_projects = WorkProject.select(:name).where(:record_type => 2).map {|work| work.name }
        work = Array.new
        work_projects.each_slice(3) do |work_project|
        	work << work_project
        end
        render json: work
      when "farmer_group"
      	farmer_groups = FarmerProfile.joins(:user).where("users.is_farmer = true and users.is_check_farmer = true").group(:ps_group)
        farmer_group = Array.new
        farmer_groups.each do |fg|
        	farmer_group << fg.ps_group
        end
        render json: farmer_group
      when "farmer_list"
      	farmer_lists = FarmerProfile.joins(:user).where("farmer_profiles.ps_group = ?",params[:group])
        farmer = Array.new
        farmer_lists.each do |fl|
          farmer_list = Hash.new
          farmer_list["id"] = fl.user_id
        	farmer_list["name"] = fl.name
          farmer_list["front_name"] = fl.front_name
        	farmer_list["user_pic_url"] = fl.user_pic_url
        	farmer_list["introduce"] = fl.introduce
          farmer_list["farmer_info"] = "#{@root_domain}/farmers/#{fl.user_id}"
          farmer_list["farmer_record"] = "#{@root_domain}/farmers/#{fl.user_id}/work_record"
          farmer << farmer_list
        end
        render json: farmer
      when "farmer_work_wall"
        farmer_profile = FarmerProfile.find_by(:name => params[:name])#, :fb_uid => params[:uid])
        total = Array.new
        text = Array.new
        result = Hash.new
        if farmer_profile.present?
          result["register"] = true
          group = CampaignGroup.find_by(:user_id => farmer_profile.user_id)
          group.present? ? result["join"] = true : result["join"] = false
        else
          result["register"] = false
          result["join"] = false
        end
        text << result
        total << text
        ua = Array.new
        url = Hash.new
        url[:type] = "text"
        url[:text] = "#{@root_domain}/farmers/#{farmer_profile.user_id}" if farmer_profile.present?
        ua << url if farmer_profile.present?
        total << ua if farmer_profile.present?
        render json: total
      when "farmer_proposal"
        farmer_profile = FarmerProfile.find_by(:name => params[:name])#, :fb_uid => params[:uid])
        total = Array.new
        text = Array.new
        result = Hash.new
        proposal = Array.new
        if farmer_profile.present?
          result["register"] = true
          campaign_ids = Campaign.where(:status => 3).map {|campaign| campaign.id }
          groups = CampaignGroup.where(:user_id => farmer_profile.user_id, :campaign_id => campaign_ids).limit(10)
          if groups.present? 
            result["join"] = true 
            text_0 = Hash.new
            text_0["name"] = "TEAFU.MENU.B2B.02.01"
            text_0["type"] = "text"
            text_0["text"] = "[[FULLNAME]]這是您目前參與的提案："
            text_0["delay"] = 1
            proposal << text_0
            proposal_1 = Array.new
            groups.each do |group|
              if group.campaign.end_date > Date.today
                remain_day = (group.campaign.end_date - Date.today).to_i
                amount_raised = group.campaign.amount_raised
                percentage = 100*(amount_raised.to_f / group.campaign.goal)
                income = group.income
                supporter = group.campaign.orders.is_paid.size
                img = group.campaign.campaign_image.campaign_path
                line = '{"title": "' + "#{group.campaign.title}"+ '","subtitle": "提案剩餘: ' + "#{remain_day}" + '天\n目前達成: ' + "#{percentage}%" + '\n預計收益: ' + "#{number_to_currency(income, precision: 0)}" + '元\n支持人數: ' + "#{supporter}" + '","image_url": "' + "#{img}" + '","buttons": [{"type": "web_url","title": "查看詳細內容","url": "' + "#{@project_domain}/campaigns/#{group.campaign.slug}" + '"}]}'      
                proposal_1 << JSON.parse(line)
              end
            end
          else
            result["join"] = false
            text_0 = Hash.new
            text_0["name"] = "TEAFU.MENU.B2B.05.01"
            text_0["type"] = "text"
            text_0["text"] = "[[FULLNAME]]您好，您目前沒有參與任何提案。"
            text_0["delay"] = 1
            proposal << text_0
            text_2 = Hash.new
            text_2["name"] = "TEAFU.MENU.B2B.05.02"
            text_2["type"] = "text"
            text_2["text"] = "您也可以參考其他成員目前正在進行的活動："
            text_2["delay"] = 1
            proposal << text_2
            proposal_1 = Array.new
            user = User.joins(:farmer_profile).where("farmer_profiles.name = ? and users.is_farmer = true and users.is_check_farmer = true", params[:name])
            similar_user = FarmerProfile.where(:category => user[0].farmer_profile.category).map {|user| user.user_id }
            campaigns = Campaign.where(:status => 3, :user_id => similar_user).limit(10)
            campaigns.each do |campaign|
              remain_day = (campaign.end_date - Date.today).to_i
              amount_raised = campaign.amount_raised
              percentage = 100*(amount_raised.to_f / campaign.goal)
              description = campaign.description.first(40)
              text_1 = Hash.new
              text_1["title"] = campaign.title
              text_1["subtitle"] = "#{description}\n\n剩餘時間: #{remain_day}天\n目前達成: #{percentage}%\n支持人數: #{campaign.orders.is_paid.size}人"
              text_1["image_url"] = campaign.campaign_image.campaign_path
              text_1["buttons"] = JSON.parse("[{\"type\": \"web_url\",\"title\": \"追蹤♥\",\"url\": \"#{@root_domain}/stories/13\"}, {\"type\": \"web_url\",\"title\": \"查看內容\",\"url\": \"" + "#{@project_domain}/campaigns/#{campaign.slug}" + '"}]')
              proposal_1 << text_1
            end
          end
        else
          result["register"] = false
          result["join"] = false
          text_0 = Hash.new
          text_0["name"] = "TEAFU.MENU.B2B.04.01"
          text_0["type"] = "text"
          text_0["text"] = "[[FULLNAME]]您好，您是否還未完成我們的小農註冊呢？ 如果還沒請點選下方網址，立即體驗免費的服務喔，請點選："
          text_0["delay"] = 1
          proposal << text_0
          text_2 = Hash.new
          text_2["name"] = "TEAFU.MENU.B2B.04.02"
          text_2["type"] = "text"
          text_2["text"] = "https://www.messenger.com/t/sogiagri"
          text_2["delay"] = 1
          proposal << text_2
        end
        text << result
        total << text
        total << proposal if proposal != nil
        total << proposal_1 if proposal_1 != nil
        render json: total
      when "recomm_proposal"
        campaigns = Campaign.where(:status => 3).limit(10)
        total = Array.new
        proposal = Array.new
        proposal_1 = Array.new
        result = Hash.new
        text_t = Array.new
        text_2 = Hash.new
        farmer_profile = FarmerProfile.find_by(:name => params[:name])#, :fb_uid => params[:uid])
        result["register"] = farmer_profile.present? ? true : false
        campaign_ids = Campaign.where(:status => 3).map {|campaign| campaign.id }
        groups = CampaignGroup.where(:campaign_id => campaign_ids).limit(10)
        result["join"] = groups.present? ? true : false
        proposal << result
        total << proposal
        text_2["NAME"] = "TEAFU.MENU.B2C.02.01"
        text_2["type"] = "text"
        text_2["text"] = "Hi [[FULLNAME]]！來看這些提案故事，一定會有您喜歡的。"
        text_2["delay"] = 1
        text_t << text_2
        total << text_t
        campaigns.each do |campaign|
          remain_day = (campaign.end_date - Date.today).to_i
          amount_raised = campaign.amount_raised
          percentage = 100*(amount_raised.to_f / campaign.goal)
          description = campaign.description.first(40)
          text = Hash.new
          text["title"] = campaign.title
          text["subtitle"] = "#{description}\n\n剩餘時間: #{remain_day}天\n目前達成: #{percentage}%\n支持人數: #{campaign.orders.is_paid.size}人"
          text["image_url"] = campaign.campaign_image.campaign_path
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
          text["buttons"] = buttons
          proposal_1 << text
        end
        total << proposal_1
        render json: total
      when "similar_proposal"
        user = User.joins(:farmer_profile).where("farmer_profiles.name = ? and users.is_farmer = true and users.is_check_farmer = true", params[:name])
        similar_user = FarmerProfile.where(:category => user[0].farmer_profile.category).map {|user| user.user_id }
        campaigns = Campaign.where(:status => 3, :user_id => similar_user).limit(10)
        proposal = Array.new
        campaigns.each do |campaign|
          remain_day = (campaign.end_date - Date.today).to_i
          amount_raised = campaign.amount_raised
          percentage = 100*(amount_raised.to_f / campaign.goal)
          description = campaign.description.first(40)
          text = Hash.new
          text["title"] = campaign.title
          text["subtitle"] = "#{description}\n\n剩餘時間: #{remain_day}天\n目前達成: #{percentage}%\n支持人數: #{campaign.orders.is_paid.size}人"
          text["image_url"] = campaign.campaign_image.campaign_path
          text["buttons"] = JSON.parse("[{\"type\": \"web_url\",\"title\": \"追蹤♥\",\"url\": \"#{@root_domain}/stories/13\"}, {\"type\": \"web_url\",\"title\": \"查看內容\",\"url\": \"" + "#{@project_domain}/campaigns/#{campaign.slug}" + '"}]')
          proposal << text
        end
        render json: proposal
      when "fb_track"
        campaign = Campaign.find_by_slug(params[:slug])
        is_binding = Authorization.find_by(:uid => params[:scoped_id])
        # UserBehavior.where("scoped_id = ? and payload LIKE ?", params[:scoped_id], "%04.0%")
        if is_binding.present?
          fb_track = FbTrack.find_or_create_by(:scoped_id => params[:scoped_id], :campaign_id => campaign.id)
          total = Array.new
          text = Array.new
          text_1 = Hash.new
          # text_1["name"] = "TEAFU.MENU.B2C.06.01"
          text_1["type"] = "text"
          text_1["text"] = "您已完成追蹤，若有這項提案最新消息茶福會通知您唷。"
          text_1["delay"] = 1
          text << text_1
          text_2 = Hash.new
          # text_2["name"] = "TEAFU.MENU.B2C.06.02"
          text_2["type"] = "text"
          text_2["text"] = "還有～還有～其他提案也很精彩值得你關注喔。"
          text_2["delay"] = 1
          text << text_2
          total << text
        end
        customization = YAML.load_file("config/customization.yml")
        uri = URI.parse(customization[:user_message_post])
        user = customization[:user]
        password = customization[:password]
        post_data = {'recepient_id'=> params[:scoped_id], 'user' => user, 'password' => password, 'elements' => total }.to_json
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
        req.body = post_data
        res = https.request(req)
        File.open("#{Rails.root}/log/mm.log", "a+") do |file|
          file.syswrite(%(#{Time.now.iso8601}: #{params[:scoped_id]} \n---------------------------------------------\n\n))
        # end
        # File.open("#{Rails.root}/log/mm.log", "a+") do |file|
          file.syswrite(%(#{Time.now.iso8601}: #{total} \n---------------------------------------------\n\n))
        # end
        # File.open("#{Rails.root}/log/mm.log", "a+") do |file|
          file.syswrite(%(#{Time.now.iso8601}: #{res.body} \n---------------------------------------------\n\n))
        end
        # render json: post_data
        render partial: "shared/fb"
      when "subscription"
        subscription = UserSubscription.find_or_create_by(:scoped_id => params[:scoped_id], :full_name => params[:full_name])
        render json: "Subscription completed"
      when /message/
      	case params[:key]
      	when "list"
          type = params[:type].upcase
      		mo = Wording.where("name like '%#{type}%'").order(:name)
      		wording = Array.new
      		mo.each do |m|
      			wording << m.name
      		end
      		render json: wording
      	when /./
      		wording = Array.new
      		key = params[:key].split('.')
          type = params[:type].upcase
      		key.each do |k|
            wd = Wording.where("name like '%#{type}.#{k}%'").order(:name)
            word = Array.new
            wd.each do |w|
            	word << JSON.parse(w.content)
            end
            wording << word
      		end
      		render json: wording
      	else
          type = params[:type].upcase
      		mo = Wording.where("name like '%#{type}.#{params[:key]}%'").order(:name)
      		wording = Array.new
      		mo.each do |m|
      			wording << JSON.parse(m.content)
      		end
      		render json: wording
      	end
      when "menu.b2c"
        type = params[:type].upcase
        mo = Wording.where("name like '%#{type}.#{params[:key]}%'").order(:name)
        wording = Array.new
        mo.each do |m|
          wording << JSON.parse(m.content)
        end
        render json: wording
      when "menu.b2b"
        type = params[:type].upcase
        mo = Wording.where("name like '%#{type}.#{params[:key]}%'").order(:name)
        similar_user = FarmerProfile.where(:category => "茶").map {|user| user.user_id }
        campaigns = Campaign.where(:status => 3, :user_id => similar_user).limit(10)
        proposal = Array.new
        campaigns.each do |campaign|
          remain_day = (campaign.end_date - Date.today).to_i
          amount_raised = campaign.amount_raised
          percentage = 100*(amount_raised.to_f / campaign.goal)
          description = campaign.description.first(40)
          text = Hash.new
          text["title"] = campaign.title
          text["subtitle"] = "#{description}\n\n剩餘時間: #{remain_day}天\n目前達成: #{percentage}%\n支持人數: #{campaign.orders.is_paid.size}人"
          text["image_url"] = campaign.campaign_image.campaign_path
          text["buttons"] = JSON.parse("[{\"type\": \"web_url\",\"title\": \"追蹤♥\",\"url\": \"#{@root_domain}/stories/13\"}, {\"type\": \"web_url\",\"title\": \"查看內容\",\"url\": \"" + "http://#{@project_domain}/campaigns/#{campaign.slug}" + '"}]')
          proposal << text
        end
        wording = Array.new

        mo.each do |m|
          if m.content.include? 'similar_proposal'
            aa = m.content.gsub("[similar_proposal]",proposal.to_s)
            aa = aa.gsub("=>", ":")
            wording << JSON.parse(aa)
          else
            wording << JSON.parse(m.content)
          end
        end
        render json: wording
      when /level/
      	case params[:key]
      	when "list"
          type = params[:type].upcase
      		mo = Wording.where("name like '%#{type}%'").order(:name)
      		wording = Array.new
      		mo.each do |m|
      			wording << m.name
      		end
      		render json: wording
      	when /./
          type = params[:type].upcase
      		wording = Array.new
      		key = params[:key].split('.')
      		key.each do |k|
            wd = Wording.where("name like '%#{type}.#{k}%'").order(:name)
            word = Array.new
            wd.each do |w|
            	word << JSON.parse(w.content)
            end
            wording << word
      		end
      		render json: wording
      	else
          type = params[:type].upcase
      		mo = Wording.where("name like '%#{type}.#{params[:key]}%'").order(:name)
      		wording = Array.new
      		mo.each do |m|
      			wording << JSON.parse(m.content)
      		end
      		render json: wording
      	end
      when "reply_word"
        effect_words = ReplyWord.where("start_time < ? and end_time > ? and enabled = true", Time.now, Time.now).order(:end_time).limit(10)
        first_word = WorkRecord.last
        wording = Array.new
        wording << first_word.work_project
        effect_words.each do |effect_word|
          wording << effect_word.show_name
        end
        render json: wording
      when "proposal_link" #農友參與的提案
        farmer_profile = FarmerProfile.find_by(:name => params[:name])#, :fb_uid => params[:uid])
        total = Array.new
        text = Array.new
        text_a = Array.new
        result = Hash.new
        if farmer_profile.present?
          result["register"] = true
          group = CampaignGroup.find_by(:user_id => farmer_profile.user_id)
          if group.present?
            text_1 = Hash.new
            text_1["name"] = "TEAFU.MENU.B2B.03.01"
            text_1["type"] = "text"
            text_1["text"] = "[[FULLNAME]]您好，這是您參與的所有提案，請點選下方網址："
            text_1["delay"] = 1
            text_a << text_1
            text_2 = Hash.new
            text_2["name"] = "TEAFU.MENU.B2B.03.02"
            text_2["type"] = "text"
            text_2["text"] = "#{@root_domain}/work_records/join_projects"
            text_2["delay"] = 1
            text_a << text_2
            result["join"] = true
          else
            result["join"] = false
            text_1 = Hash.new
            text_1["name"] = "TEAFU.MENU.B2B.05.01"
            text_1["type"] = "text"
            text_1["text"] = "[[FULLNAME]]您好，您目前沒有參與任何提案。"
            text_1["delay"] = 1
            text_a << text_1
            text_2 = Hash.new
            text_2["name"] = "TEAFU.MENU.B2B.05.02"
            text_2["type"] = "text"
            text_2["text"] = "您也可以參考其他成員目前正在進行的活動："
            text_2["delay"] = 1
            text_a << text_2
            proposal = Array.new
            user = User.joins(:farmer_profile).where("farmer_profiles.name = ? and users.is_farmer = true and users.is_check_farmer = true", params[:name])
            similar_user = FarmerProfile.where(:category => user[0].farmer_profile.category).map {|user| user.user_id }
            campaigns = Campaign.where(:status => 3, :user_id => similar_user).limit(10)
            campaigns.each do |campaign|
              remain_day = (campaign.end_date - Date.today).to_i
              amount_raised = campaign.amount_raised
              percentage = 100*(amount_raised.to_f / campaign.goal)
              description = campaign.description.first(40)
              text_3 = Hash.new
              text_3["title"] = campaign.title
              text_3["subtitle"] = "#{description}\n\n剩餘時間: #{remain_day}天\n目前達成: #{percentage}%\n支持人數: #{campaign.orders.is_paid.size}人"
              text_3["image_url"] = campaign.campaign_image.campaign_path
              text_3["buttons"] = JSON.parse("[{\"type\": \"web_url\",\"title\": \"追蹤♥\",\"url\": \"#{@root_domain}/stories/13\"}, {\"type\": \"web_url\",\"title\": \"查看內容\",\"url\": \"" + "#{@project_domain}/campaigns/#{campaign.slug}" + '"}]')
              proposal << text_3
            end
          end
        else
          result["register"] = false
          result["join"] = false
          text_1 = Hash.new
          text_1["name"] = "TEAFU.MENU.B2B.04.01"
          text_1["type"] = "text"
          text_1["text"] = "[[FULLNAME]]您好，您是否還未完成我們的小農註冊呢？ 如果還沒請點選下方網址，立即體驗免費的服務喔，請點選："
          text_1["delay"] = 1
          text_a << text_1
          text_2 = Hash.new
          text_2["name"] = "TEAFU.MENU.B2B.04.02"
          text_2["type"] = "text"
          text_2["text"] = "https://www.messenger.com/t/sogiagri"
          text_2["delay"] = 1
          text_a << text_2
        end
        text << result
        total << text
        total << text_a
        total << proposal if proposal.present?
        render json: total
      when "user_proposal"
        total = Array.new
        text = Array.new
        text_a = Array.new
        result = Hash.new
        text_1 = Hash.new
        text_3 = Hash.new
        auth = Authorization.find_by_uid(params[:uid])
        if auth.present?
          result["register"] = true
          if auth.user.orders.size > 0 
            text_3_a = Array.new
            result["join"] = true
            text_3["name"] = "TEAFU.MENU.B2C.05.01"
            text_3["type"] = "text"
            text_3["text"] = "[[FULLNAME]]您好，這是您支持中的提案："
            text_3["delay"] = 1
            text_3_a << text_3
            auth.user.orders.order(:paid).limit(10).each do |order|
              if order.goody.campaign.end_date > Date.today
                remain_day = (order.goody.campaign.end_date - Date.today).to_i
                amount_raised = order.goody.campaign.amount_raised
                percentage = 100*(amount_raised.to_f / order.goody.campaign.goal)
                text_2_c = Hash.new
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
          else
            result["join"] = false
            text_1["name"] = "TEAFU.MENU.B2C.05.02"
            text_1["type"] = "text"
            text_1["text"] = "咦！目前您尚未有紀錄喔。這是最新最熱門的提案，若有喜歡記得加入愛心，我會通知第一手的訊息給您。"
            text_1["delay"] = 1
            total = Array.new
            proposal = Array.new
            proposal_1 = Array.new
            text_t = Array.new
            text_2 = Hash.new
            campaigns = Campaign.where(:status => 3).limit(10)       
            # text_2["NAME"] = "TEAFU.MENU.B2C.02.01"
            # text_2["type"] = "text"
            # text_2["text"] = "Hi [[FULLNAME]]！來看這些提案故事，一定會有您喜歡的。"
            # text_2["delay"] = 1
            campaigns.each do |campaign|
              remain_day = (campaign.end_date - Date.today).to_i
              amount_raised = campaign.amount_raised
              percentage = 100*(amount_raised.to_f / campaign.goal)
              description = campaign.description.first(40)
              text_c = Hash.new
              text_c["title"] = campaign.title
              text_c["subtitle"] = "#{description}\n\n剩餘時間: #{remain_day}天\n目前達成: #{percentage}%\n支持人數: #{campaign.orders.is_paid.size}人"
              text_c["image_url"] = campaign.campaign_image.campaign_path
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
              text_c["buttons"] = buttons
              proposal_1 << text_c
            end
          end
        else
          result["register"] = false
          result["join"] = false
          text_1["name"] = "TEAFU.MENU.B2C.03.01"
          text_1["type"] = "text"
          text_1["text"] = "[[FULLNAME]]要查詢服務嗎？茶福需要您的同意才能開啟所有服務，請先點擊下方連結進行登入。"
          text_1["delay"] = 1
          text_2 = Hash.new
          text_2["name"] = "TEAFU.MENU.B2C.03.02"
          text_2["type"] = "text"
          text_2["text"] = "#{@root_domain}/users/fb_binding?scoped_id=[[RECIPIENT_ID]]"
          text_2["delay"] = 1
        end
        text << result
        total << text
        total << text_3_a if text_3_a.present?
        text_a << text_1 if text_1 != {}
        text_a << text_2 if text_2.present?
        total << text_a
        total << proposal_1 if proposal_1.present?
        render json: total
      when "farmer_determine"
        farmer_profile = FarmerProfile.find_by(:name => params[:name])#, :fb_uid => params[:uid])
        text = Array.new
        result = Hash.new
        if farmer_profile.present?
          result["register"] = true
          group = CampaignGroup.find_by(:user_id => farmer_profile.user_id)
          group.present? ? result["join"] = true : result["join"] = false
        else
          result["register"] = false
          result["join"] = false
        end
        text << result
        render json: text
      when "finish_subscription"
        card = Array.new
        card_text = Hash.new
        card_text["text"] = "TEXT"
        quick_replies = Array.new
        t1 = Hash.new
        t1["content_type"] = "text"
        t1["title"] = "茶福～我完成喔！"
        t1["payload"] = "C_0"
        quick_replies << t1
        card_text["quick_replies"] = quick_replies
        card << card_text
        customization = YAML.load_file("config/customization.yml")
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
          file.syswrite(%(#{Time.now.iso8601}: #{card} \n---------------------------------------------\n\n))
          file.syswrite(%(#{Time.now.iso8601}: #{res.body} \n---------------------------------------------\n\n))
        end
        render text: "ok"
      when "active_ivg"
        mo = Wording.where("name like '%TEAFU.CSI%' or name like '%TEAFU.TEST%'").order(:name)
        wording = ""
        mo.each do |m|
          wording += m.content[1..-2]
          wording += ","
        end
        aa = JSON.parse("[" + wording[0..-2] + "]")
        render json: aa
      when "user_analyze"
        customization = YAML.load_file("config/customization.yml")
        case [params[:v],params[:d]]
        when ["0.01",customization[:domain_arg]]
          ua = UserAnalyze.new
          ua.f_id = params[:f_id] if params[:f_id].present?
          ua.origin = params[:origin] if params[:origin].present?
          ua.send_to_module = params[:send_to_module] if params[:send_to_module].present?
          ua.keyword = params[:keyword] if params[:keyword].present?
          ua.gender = params[:gender] if params[:gender].present?
          ua.age = params[:age] if params[:age].present?
          ua.name = params[:name] if params[:name].present?
          ua.save!
          render text: "ok"
        end
      when "greeting"
        customization = YAML.load_file("config/customization.yml")
        case [params[:v],params[:d]]
        when ["0.01",customization[:domain_arg]]
          gg = Greeting.find_or_initialize_by(:f_id => params[:f_id])
          gg.name = params[:name]
          gg.origin = params[:origin]
          gg.is_start_use = (params[:is_start_use] == "1" ? true : false)
          word_a = Array.new
          word = Hash.new
          say_hi = true if gg.new_record?
          gg.save!
          if (Time.now - gg.updated_at)/3600 > 12 or say_hi == true
            name = params[:name]
            case Time.now.strftime('%H').to_i
            when 0..4
              sta = "晚安！"
            when 5..10
              sta = "早安！"
            when 11..13
              sta = "午安！"
            when 14..17
              sta = "下午好~"
            when 18..23
              sta = "晚安！"
            end
            word["type"] = "text"
            word["title"] = "Hi #{name} #{sta}"
            word["delay"] = "1"
            gg.updated_at = Time.now
          end
          word_a << word
          gg.save!
          render json: word_a
        end
      when "farmer_group_list"
        customization = YAML.load_file("config/customization.yml")
        case [params[:v],params[:d]]
        when ["0.01",customization[:domain_arg]]
          farmer_groups = FarmerProfile.joins(:user).where("users.is_farmer = true and users.is_check_farmer = true").group(:ps_group).map{|ps|ps.ps_group}
          farmer_group = Array.new
          fg_text_h = Array.new
          fg_text = Hash.new
          fg_text[:NAME] = "TEAFU.MENU.B2C.10.01"
          fg_text[:type] = "text"
          fg_text[:text] = "請先幫我選擇產銷班！"
          fg_text[:delay] = "1"
          fg_text_h << fg_text
          farmer_group << fg_text_h
          fg_card_t = Array.new
          farmer_groups.each_with_index do |fg, i|
            i+=2
            fg_card = Hash.new
            fg_card[:NAME] = "TEAFU.MENU.B2C.10.0#{i}"
            fg_card[:title] = fg
            fg_card[:subtitle] = "用好茶邀請您，一同為台灣的好山好水盡一份力，讓更多的人願意加入守護土地與水源的行動。"
            fg_card[:image_url] = "https://soginationaltest.s3-ap-southeast-1.amazonaws.com/project/campaign_image/file/5/campaign_path_0039.png"
            fg_card[:buttons] = []
            fg_card_b = Hash.new
            fg_card_b[:type] = "postback"
            fg_card_b[:title] = "查看成員"
            fg_card_b[:payload] = "TF.06.0#{i}"
            fg_card[:buttons] << fg_card_b
            fg_card_t << fg_card
          end
          farmer_group << fg_card_t
          farmer_groups.each_with_index do |fg, i|
            i+=2
            list_talk = Array.new
            fg_list_talk = Hash.new
            fg_list_talk[:Name] = "TEAFU.MENU.B2C.TF.10.0#{i}.01"
            fg_list_talk[:type] = "text"
            fg_list_talk[:title] = "這裡都是致力推動友善耕作，投入心力保護土地和環境的友善小農，快來看看他們的田園生活吧！"
            fg_list_talk[:delay] = "1"
            list_talk << fg_list_talk
            farmer_group << list_talk
            farmer_group_lists = FarmerProfile.where(:ps_group => fg)
            farmer_group_lists.each do |f_list|
              fl_card = Hash.new
              fl_card[:NAME] = "TEAFU.MENU.B2C.TF.10.0#{i}.02"
              fl_card[:title] = f_list.ps_group
              fl_card[:subtitle] = f_list.name
              fl_card[:image_url] = f_list.user_pic_url
              fl_card[:buttons] = []
              fl_card_b = Hash.new
              fl_card_b[:type] = "web_url"
              fl_card_b[:title] = "我想進一步認識"
              fl_card_b[:url] = "https://www.ugooz.cc/farmers/#{f_list.user_id}"
              fl_card_c = Hash.new
              fl_card_c[:type] = "web_url"
              fl_card_c[:title] = "查看生產紀錄"
              fl_card_c[:url] = "https://www.ugooz.cc/farmers/#{f_list.user_id}/work_record"
              fl_card[:buttons] << fl_card_b
              fl_card[:buttons] << fl_card_c
              farmer_group << fl_card
            end
          end
          render json: farmer_group
        end
      when "jump"
        customization = YAML.load_file("config/customization.yml")
        case [params[:v],params[:d]]
        when ["0.01",customization[:domain_arg]]
          arg = params[:arg]
          f_id = params[:f_id]
          aa = Authorization.find_by_uid(f_id)
          bb = UserSubscription.find_by_scoped_id(f_id)
          ww = ParameterSet.find_by_ref(arg)
          if aa.present?
            w = ww.user
          elsif bb.present?
            w = ww.subscribe_guest
          else
            w = ww.guest
          end  
          render json: w       
        end
      when "start_up"
        customization = YAML.load_file("config/customization.yml")
        case [params[:v],params[:d]]
        when ["0.01",customization[:domain_arg]]
          u = UserAnalyze.find_by(:f_id => params[:f_id])
          inter_to = Array.new
          inter_ta = Hash.new
          if u.present?
            cate = PersonalInterplay.size
            if cate == 1
              inter_ta[:NAME] = "TEAFU.MENU.B2C.04.01"
              inter_ta[:type] = "text"
              inter_ta[:text] = "歡迎來到友故事！想要隨時隨地來杯好茶嗎，我們有許多茶的故事及有趣的測驗，還提供個人專屬的茶諮詢服務喔~"
              inter_ta[:delay] = "1"
            else

            end
          else
            cate = PersonalOnterplay.size
            if cate == 1
              inter_ta[:NAME] = "TEAFU.MENU.B2C.04.01"
              inter_ta[:type] = "text"
              inter_ta[:text] = "很高興再見到你！我們新增了許多茶的故事和測驗喔，趕緊來補一下~"
              inter_ta[:delay] = "1"
            else
              inter_ta[:NAME] = "TEAFU.MENU.B2C.04.01"
              inter_ta[:text] = "很高興再見到你！我們新增了許多茶、可可 和咖啡的故事和活動喔~你想先看哪一個呢?"
              inter_ta[:quick_replies] = []
              qr = Hash.new
            end
          end
          inter_to << inter_ta
        end
      end
		else
      case [params[:v],params[:m]]
      when ["v0.01","return_data"]
        case params[:arg]
        when ""
          case params[:ref]
          when ""
            case params[:start]
            when "" #個人化問候語
              gg = Greeting.find_or_initialize_by(:uid => params[:uid])
              gg.name = params[:n]
              gg.start = (params[:start] == "1" ? true : false)
              word_a = Array.new
              word = Hash.new
              say_hi = true if gg.new_record?
              gg.save!
              if (Time.now - gg.updated_at)/3600 > 12 or say_hi == true
                name = params[:n]
                case Time.now.strftime('%H').to_i
                when 0..4
                  sta = "晚安！"
                when 5..10
                  sta = "早安！"
                when 11..13
                  sta = "午安！"
                when 14..17
                  sta = "下午好~"
                when 18..23
                  sta = "晚安！"
                end
                word["type"] = "text"
                word["title"] = "Hi #{name} #{sta}"
                word["delay"] = "1"
                gg.updated_at = Time.now
              end
              word_a << word
              gg.save!
              render json: word_a
            when "1" #B2C 個人化啟動互動
              u = UserAnalyze.find_by(:f_id => params[:uid])
              inter_t = Array.new
              inter_to = Array.new
              inter_ta = Hash.new
              inter_tb = Hash.new
              if u.present?
                cate = PersonalInterplay.all.size
                if cate == 1
                  inter_ta[:NAME] = "TEAFU.MENU.B2C.09.01"
                  inter_ta[:type] = "text"
                  inter_ta[:text] = "很高興再見到你！我們新增了許多茶的故事和測驗喔，趕緊來補一下~"
                  inter_ta[:delay] = "1"
                  inter_tb[:NAME] = "TEAFU.MENU.B2C.09.02"
                  inter_tb[:type] = "text"
                  inter_tb[:text] = "你想要先玩玩測驗、看看故事，還是來支目前最火紅的影片呢?"
                  inter_tb[:delay] = "1"
                  next_inter = JSON.parse(PersonalInterplay.first.start_model)
                else
                  inter_ta[:NAME] = "TEAFU.MENU.B2C.09.01"
                  inter_ta[:text] = "很高興再見到你！我們新增了許多茶、可可 和咖啡的故事和活動喔~你想先看哪一個呢?"
                  inter_ta[:quick_replies] = []
                  PersonalInterplay.all.each do |pi|
                    qr = Hash.new
                    qr[:content_type] = "text"
                    qr[:payload] = "TEAFU.MENU.B2C.TF.09.0#{i}"
                    qr[:title] = pi.title
                    inter_ta[:quick_replies] << qr
                  end
                  inter_tb[:NAME] = "TEAFU.MENU.B2C.09.02"
                  inter_tb[:type] = "text"
                  inter_tb[:text] = "你想要先玩玩測驗、看看故事，還是來支目前最火紅的影片呢?"
                  inter_tb[:delay] = "1"
                end
              else
                cate = PersonalInterplay.all.size
                if cate == 1
                  inter_ta[:NAME] = "TEAFU.MENU.B2C.09.01"
                  inter_ta[:type] = "text"
                  inter_ta[:text] = "歡迎來到友故事！想要隨時隨地來杯好茶嗎，我們有許多茶的故事及有趣的測驗，還提供個人專屬的茶諮詢服務喔~"
                  inter_ta[:delay] = "1"
                  inter_tb[:NAME] = "TEAFU.MENU.B2C.09.02"
                  inter_tb[:type] = "text"
                  inter_tb[:text] = "你想要先玩玩測驗、看看故事，還是來支目前最火紅的影片呢?"
                  inter_tb[:delay] = "1"
                  next_inter = JSON.parse(PersonalInterplay.first.start_model)
                else
                  inter_ta[:NAME] = "TEAFU.MENU.B2C.09.01"
                  inter_ta[:type] = "text"
                  inter_ta[:text] = "歡迎來到友故事！我們擁有茶、可可、咖啡相關的知識及服務喔~你想先了解哪一個呢?"
                  inter_ta[:delay] = "1"
                  PersonalInterplay.all.each do |pi|
                    qr = Hash.new
                    qr[:content_type] = "text"
                    qr[:payload] = "TEAFU.MENU.B2C.TF.09.0#{i}"
                    qr[:title] = pi.title
                    inter_ta[:quick_replies] << qr
                  end
                  inter_tb[:NAME] = "TEAFU.MENU.B2C.09.02"
                  inter_tb[:type] = "text"
                  inter_tb[:text] = "你想要先玩玩測驗、看看故事，還是來支目前最火紅的影片呢?"
                  inter_tb[:delay] = "1"
                end
              end
              inter_to << inter_ta
              inter_to << inter_tb
              inter_t << inter_to
              inter_t << next_inter
              render json: inter_t
            end
          else
            ref = params[:ref]
            uid = params[:uid]
            aa = Authorization.find_by_uid(uid)
            bb = UserSubscription.find_by_scoped_id(uid)
            ww = ParameterSet.find_by_ref_and_enabled(ref, true)
            if aa.present?
              w = ww.user
            elsif bb.present?
              w = ww.subscribe_guest
            else
              w = ww.guest
            end  
            render json: w
          end
        when "my_proposal"
          total = Array.new
          text = Array.new
          text_a = Array.new
          result = Hash.new
          text_1 = Hash.new
          text_3 = Hash.new
          auth = Authorization.find_by_uid(params[:uid])
          if auth.present?
            result["register"] = true
            if auth.user.orders.size > 0 
              text_3_a = Array.new
              result["join"] = true
              text_3["name"] = "TEAFU.MENU.B2C.05.01"
              text_3["type"] = "text"
              text_3["text"] = "#{params[:n]}您好，這是您支持中的提案："
              text_3["delay"] = 1
              text_3_a << text_3
              auth.user.orders.order(:paid).limit(10).each do |order|
                if order.goody.campaign.end_date > Date.today
                  remain_day = (order.goody.campaign.end_date - Date.today).to_i
                  amount_raised = order.goody.campaign.amount_raised
                  percentage = 100*(amount_raised.to_f / order.goody.campaign.goal)
                  text_2_c = Hash.new
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
            else
              result["join"] = false
              text_1["name"] = "TEAFU.MENU.B2C.05.02"
              text_1["type"] = "text"
              text_1["text"] = "咦！目前您尚未支持任何提案喔~這些是目前最受關注的友善提案，喜歡記得加入追蹤 ❤，我會通知您第一手消息！"
              text_1["delay"] = 1
              total = Array.new
              proposal = Array.new
              proposal_1 = Array.new
              text_t = Array.new
              text_2 = Hash.new
              campaigns = Campaign.where(:status => 3).limit(10)       
              campaigns.each do |campaign|
                remain_day = (campaign.end_date - Date.today).to_i
                amount_raised = campaign.amount_raised
                percentage = 100*(amount_raised.to_f / campaign.goal)
                description = campaign.description.first(40)
                text_c = Hash.new
                text_c["title"] = campaign.title
                text_c["subtitle"] = "#{description}\n\n剩餘時間: #{remain_day}天\n目前達成: #{percentage}%\n支持人數: #{campaign.orders.is_paid.size}人"
                text_c["image_url"] = campaign.campaign_image.campaign_path
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
                text_c["buttons"] = buttons
                proposal_1 << text_c
              end
            end
          else
            result["register"] = false
            result["join"] = false
            text_1["name"] = "TEAFU.MENU.B2C.03.01"
            text_1["type"] = "text"
            text_1["text"] = "請先登入後才能使用會員服務哦~請點擊下方連結進行FB登入~"
            text_1["delay"] = 1
            text_2 = Hash.new
            text_2["name"] = "TEAFU.MENU.B2C.03.02"
            text_2["type"] = "text"
            text_2["text"] = "#{@root_domain}/users/fb_binding?scoped_id=[[RECIPIENT_ID]]"
            text_2["delay"] = 1
          end
          text << result
          total << text
          total << text_3_a if text_3_a.present?
          text_a << text_1 if text_1 != {}
          text_a << text_2 if text_2.present?
          total << text_a
          total << proposal_1 if proposal_1.present?
          render json: total
        when /-/
          ids = ParameterSet.all.map { |f| f.id }
          params[:arg].split("-").each do |a|
            ww = ParameterSet.where("id in (?) and ref like ?", ids, "%#{a}%")
            ids = ww.map { |w| w.id }
          end
          aa = Authorization.find_by_uid(uid)
          bb = UserSubscription.find_by_scoped_id(uid)
          set = ParameterSet.find_by_id_and_enabled(ids, true)
          if aa.present?
            w = set.user
          elsif bb.present?
            w = set.subscribe_guest
          else
            w = set.guest
          end
          render json: w
        end
      when ["v0.01","collect_data"]
        ua = UserAnalyze.new
        ua.f_id = params[:uid] if params[:uid].present?
        ua.origin = params[:pl] if params[:pl].present?
        ua.keyword = params[:ref] if params[:ref].present?
        ua.gender = params[:g] if params[:g].present?
        ua.name = params[:n] if params[:n].present?
        ua.save!
        render text: "ok"
      when ["v0.01","stactic_all"]
        js = Wording.where(:enabled => true).where.not(:wording_cat_id => nil)
        wording = Array.new
        js.each do |j|
          wording << JSON.parse(j.content)
        end
        farmer_groups = FarmerProfile.joins(:user).where("users.is_farmer = true and users.is_check_farmer = true").group(:ps_group).map{|ps|ps.ps_group}
        farmer_group = Array.new
        fg_text_h = Array.new
        fg_text = Hash.new
        fg_text[:NAME] = "TEAFU.MENU.B2C.10.01"
        fg_text[:type] = "text"
        fg_text[:text] = "請先幫我選擇產銷班！"
        fg_text[:delay] = "1"
        fg_text_h << fg_text
        farmer_group << fg_text_h
        fg_card_t = Array.new
        farmer_groups.each_with_index do |fg, i|
          i+=2
          fg_card = Hash.new
          fg_card[:NAME] = "TEAFU.MENU.B2C.10.0#{i}"
          fg_card[:title] = fg
          fg_card[:subtitle] = "用好茶邀請您，一同為台灣的好山好水盡一份力，讓更多的人願意加入守護土地與水源的行動。"
          fg_card[:image_url] = "https://soginationaltest.s3-ap-southeast-1.amazonaws.com/project/campaign_image/file/5/campaign_path_0039.png"
          fg_card[:buttons] = []
          fg_card_b = Hash.new
          fg_card_b[:type] = "postback"
          fg_card_b[:title] = "查看成員"
          fg_card_b[:payload] = "TF.10.0#{i}"
          fg_card[:buttons] << fg_card_b
          fg_card_t << fg_card
        end
        farmer_group << fg_card_t
        fgl_t = Array.new
        farmer_groups.each_with_index do |fg, i|
          i+=2
          list_talk = Array.new
          fg_list_talk = Hash.new
          fg_list_talk[:Name] = "TEAFU.MENU.B2C.TF.10.0#{i}.01"
          fg_list_talk[:type] = "text"
          fg_list_talk[:title] = "這裡都是致力推動友善耕作，投入心力保護土地和環境的友善小農，快來看看他們的田園生活吧！"
          fg_list_talk[:delay] = "1"
          list_talk << fg_list_talk
          farmer_group << list_talk
          farmer_group_lists = FarmerProfile.where(:ps_group => fg)
          fgl = Array.new
          farmer_group_lists.each_with_index do |f_list, x|
            x+=1
            fl_card = Hash.new
            fl_card[:NAME] = "TEAFU.MENU.B2C.TF.10.0#{i}.02.0#{x}"
            fl_card[:title] = f_list.ps_group
            fl_card[:subtitle] = f_list.name
            fl_card[:image_url] = f_list.user_pic_url
            fl_card[:buttons] = []
            fl_card_b = Hash.new
            fl_card_b[:type] = "web_url"
            fl_card_b[:title] = "我想進一步認識"
            fl_card_b[:url] = "https://www.ugooz.cc/farmers/#{f_list.user_id}"
            fl_card_c = Hash.new
            fl_card_c[:type] = "web_url"
            fl_card_c[:title] = "查看生產紀錄"
            fl_card_c[:url] = "https://www.ugooz.cc/farmers/#{f_list.user_id}/work_record"
            fl_card[:buttons] << fl_card_b
            fl_card[:buttons] << fl_card_c
            fgl << fl_card
          end
          farmer_group << fgl
        end
        wording << farmer_group
        render json: wording
      end
    end
	end
end
