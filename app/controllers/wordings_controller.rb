class WordingsController < ApplicationController

	def new
	end
	def create
		@params = params.except("utf8", "controller","action")
		@total = []
		par_name = @params.map { |k, v| k }
		@params.each_with_index do |(k, v), i|
			case k
			when /card/
				@card_t = [] if i == 0 or par_name[i-1].include?("card") == false
				v.each do |ke, va|
					card = {}
					card["NAME"] = va["Name"]
					card["title"] = va["title"]
					card["subtitle"] = va["subtitle"] if va["subtitle"].present?
					card["image_url"] = va["image_url"] if va["image_url"].present?
					card["buttons"] = []
					va.except("Name", "title", "subtitle", "image_url").each_with_index do |(key, value), i|
						bb = {}
						bb["type"] = va["buttons#{i+1}"]["type"]
						bb["title"] = va["buttons#{i+1}"]["title"]
						bb["payload"] = va["buttons#{i+1}"]["payload"] if va["buttons#{i+1}"]["payload"].present?
						bb["url"] = va["buttons#{i+1}"]["url"] if va["buttons#{i+1}"]["url"].present?
						card["buttons"] << bb
					end
					@card_t << card
				end
			when /text/
				@text_t = [] if i == 0 or par_name[i-1].include?("text") == false
				v.each do |ke, va|
					text = {}
					text["NAME"] = va["Name"]
					text["type"] = va["type"]
					text["text"] = va["text"]
					text["delay"] = va["delay"]
					@text_t << text
				end
			when /pic/
				@pic_t = [] if i == 0 or par_name[i-1].include?("pic") == false
				v.each do |ke, va|
					pic = {}
					pic["NAME"] = va["Name"]
					pic["type"] = va["type"]
					pic["url"] = va["url"]
					pic["delay"] = va["delay"]
					@pic_t << pic
				end
			when /quick/
				@quick_t = [] #if i == 0 or par_name[i-1].include?("quick") == false
				v.each do |ke, va|
					quick = {}
					quick["NAME"] = va["name"]
					quick["text"] = va["text"]
					quick["quick_replies"] = []
					va.except("name", "text").each_with_index do |(key, value), i|
						qq = {}
						qq["content_type"] = va["reply#{i+1}"]["content_type"]
						qq["payload"] = va["reply#{i+1}"]["payload"]
						qq["title"] = va["reply#{i+1}"]["title"]
						quick["quick_replies"] << qq
					end
					@quick_t << quick
				end
			when /button/
				@button_t = [] #if i == 0 or par_name[i-1].include?("button") == false
				v.each do |ke, va|
					button = {}
					button["NAME"] = va["Name"]
					button["template_type"] = "button"
					button["text"] = va["text"]
					button["buttons"] = []
					va.except("Name", "text").each_with_index do |(key, value), i|
						qq = {}
						qq["type"] = "web_url"
						qq["url"] = va["button#{i+1}"]["url"]
						qq["title"] = va["button#{i+1}"]["title"]
						button["buttons"] << qq
					end
					@button_t << button
				end
			end

			if par_name[i].include?("card")
				@total << @card_t if @card_t != nil and par_name[i+1].to_s.include?("card") == false
			end
			if par_name[i].include?("text")
				@total << @text_t if @text_t != nil and par_name[i+1].to_s.include?("text") == false
			end
			if par_name[i].include?("pic")
				@total << @pic_t if @pic_t != nil and par_name[i+1].to_s.include?("pic") == false
			end
			if par_name[i].include?("quick")
				@total << @quick_t #if @quick_t != nil and par_name[i+1].to_s.include?("quick") == false
			end
			if par_name[i].include?("button")
				@total << @button_t #if @button_t != nil and par_name[i+1].to_s.include?("button") == false
			end
		end 
	end
end
