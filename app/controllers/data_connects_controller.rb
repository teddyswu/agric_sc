class DataConnectsController < ApplicationController
	skip_before_action :verify_authenticity_token
  include ActionView::Helpers::NumberHelper
	def story
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
    		render json: '{"uid":"' + user_profile.fb_uid.to_s + '","name":"' + user_profile.name.to_s + '","front_name":"' + user_profile.front_name.to_s + '","cell_phone":"' + user_profile.cell_phone.to_s + '","certificate":"' + user_profile.certificate_photo.to_s + '","certificate_2":"' + user_profile.certificate_photo_2.to_s + '","profile_pic":"' + user_profile.pic_url.to_s + '","farmer_info":"' + "http://story.sogi.com.tw/farmers/#{user_profile.user_id}" + '","farmer_record":"' + "http://story.sogi.com.tw/farmers/#{user_profile.user_id}/work_record\"}"
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
          farmer_list["farmer_info"] = "http://story.sogi.com.tw/farmers/#{fl.user_id}"
          farmer_list["farmer_record"] = "http://story.sogi.com.tw/farmers/#{fl.user_id}/work_record"
          farmer << farmer_list
        end
        render json: farmer
      when "farmer_work_wall"
        user = User.joins(:farmer_profile).where("farmer_profiles.name = ? and users.is_farmer = true and users.is_check_farmer = true", params[:name])
        url = Array.new
        url << "http://story.sogi.com.tw/farmers/#{user[0].id}"
        render json: url
      when "farmer_proposal"
        user = User.joins(:farmer_profile).where("farmer_profiles.name = ? and users.is_farmer = true and users.is_check_farmer = true", params[:name])
        groups = CampaignGroup.where(:user_id => user[0].id).limit(10)
        campaign = Array.new
        groups.each do |group|
          if group.campaign.end_date > Date.today
            remain_day = (group.campaign.end_date - Date.today).to_i
            amount_raised = group.campaign.amount_raised
            percentage = 100*(amount_raised.to_f / group.campaign.goal)
            income = group.income
            supporter = group.campaign.orders.is_paid.size
            img = group.campaign.campaign_image.campaign_path
            line = '{"title": "' + "#{group.campaign.title}"+ '","subtitle": "提案剩餘: ' + "#{remain_day}" + '天\n目前達成: ' + "#{percentage}%" + '\n預計收益: ' + "#{number_to_currency(income, precision: 0)}" + '元\n支持人數: ' + "#{supporter}" + '","image_url": "' + "#{img}" + '","buttons": [{"type": "web_url","title": "查看詳細內容","url": "' + "http://swiss.i-sogi.com/campaigns/#{group.campaign.slug}" + '"}]}'      
            campaign << JSON.parse(line)
          end
        end
        render json: campaign
      when "recomm_proposal"
        campaigns = Campaign.where(:status => 3).limit(10)
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
          buttons = Array.new #[]
          t1 = Hash.new
          t1["type"] = "web_url"
          t1["title"] = "追蹤♥"
          t1["url"] = "http://story.sogi.com.tw/data_connects/story?motion=get&type=fb_track&scoped_id=#{params[:scoped_id]}&slug=#{campaign.slug}"
          buttons << t1
          t2 = Hash.new
          t2["type"] = "web_url"
          t2["title}"] = "查看內容"
          t2["url"] = "http://swiss.i-sogi.com/campaigns/#{campaign.slug}"
          buttons << t2
          text["buttons"] = buttons
          proposal << text
        end
        render json: proposal
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
          text["buttons"] = JSON.parse('[{"type": "web_url","title": "追蹤♥","url": "http://story.sogi.com.tw/stories/13"}, {"type": "web_url","title": "查看內容","url": "' + "http://swiss.i-sogi.com/campaigns/#{campaign.slug}" + '"}]')
          proposal << text
        end
        render json: proposal
      when "fb_track"
        campaign = Campaign.find_by_slug(params[:slug])
        fb_track = FbTrack.find_or_create_by(:scoped_id => params[:scoped_id], :campaign_id => campaign.id)
        render json: "Track OK"
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
        wording = Array.new
        mo.each do |m|
          wording << JSON.parse(m.content)
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
        url = Array.new
        url << "http://swiss.i-sogi.com/orders"
        render json: url
      when "user_proposal"
        auth = Authorization.find_by_uid(params[:uid])
        user_proposal = Array.new
        auth.user.orders.order(:paid).each do |order|
          if order.goody.campaign.end_date > Date.today
            remain_day = (order.goody.campaign.end_date - Date.today).to_i
            amount_raised = order.goody.campaign.amount_raised
            percentage = 100*(amount_raised.to_f / order.goody.campaign.goal)
            text = Hash.new
            text["title"] = order.goody.campaign.title
            text["subtitle"] = "剩餘時間: #{remain_day}天\n目前達成: #{percentage}%\n回饋項目: #{order.goody.title}\n預計寄送: #{order.goody.delivery_time}"
            text["image_url"] = order.goody.campaign.campaign_image.campaign_path
            buttons = Array.new #[]
            t1 = Hash.new
            if order.paid == false
              t1["type"] = "web_url"
              t1["title"] = "付款去"
              t1["url"] = "http://swiss.i-sogi.com/orders/#{order.id}/go_pay"
            else
              t1["type"] = "web_url"
              t1["title"] = "查看詳細記錄"
              t1["url"] = "http://swiss.i-sogi.com/campaigns/#{order.goody.campaign.slug}"
            end
            buttons << t1
            t2 = Hash.new
            t2["type"] = "web_url"
            t2["title}"] = "查看最新進度"
            t2["url"] = "http://swiss.i-sogi.com/campaigns/#{order.goody.campaign.slug}/updates"
            buttons << t2
            text["buttons"] = buttons
            user_proposal << text
          end
        end
        render json: user_proposal
      end
		end
	end
end
