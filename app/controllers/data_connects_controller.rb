class DataConnectsController < ApplicationController
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
    		check_uid = UserProfile.find_by_fb_uid(params[:uid])
    		if check_uid.blank?
    			user = User.new
    			user.email = "#{Time.now.to_i}@temp.com.tw"
    			user.password = "user_temp"
		    	user.encrypted_password = "user_temp"
		    	user.is_farmer = true
		    	user.save!
          user_profile = UserProfile.new
          user_profile.user_id = user.id
          user_profile.fb_uid = params[:uid]
          user_profile.name = params[:name]
          user_profile.cell_phone = params[:cell_phone]
          user_profile.certificate_photo = params[:certificate]
          user_profile.save!
          render json: "[{'encryption':" + "#{user.encryption}" + "},{'status':'farmer create ok'}]" and return
    		else
    			render json: "[{'uid':" + "#{params[:uid]}" + "},{'status':'uid already exists'}]" and return
    		end
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
      render json: "[{'encryption':" + "#{user.encryption}" + "},{'status':'user create ok'}]" and return
    when "user_datum"
    	user = User.find_by_encryption(params[:encryption])
    	render json: user.user_datums.select(:user_data,:id) and return
		end
	end
end
