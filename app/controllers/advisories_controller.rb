class AdvisoriesController < ApplicationController

	def index
		pl = params[:pl].split("_")
		case Time.now.strftime('%H').to_i
    when 0..4
      sta = "宵夜"
    when 5..10
      sta = "早餐"
    when 11..13
      sta = "午餐"
    when 14..17
      sta = "點心"
    when 18..23
      sta = "晚餐"
    end
    cons = Consultation.find_by(:id => pl[1])
    con_option = ConsultationOption.find(pl[2])
    auth = Authorization.find_by_uid(params[:uid])
    auth.user.user_profile.age_range > 4 ? current_age = 4 : current_age = 3
    con_content = ConsultationContent.where(:consultation_option_id => pl[2], :age_range => current_age, :gender => auth.user.user_profile.gender )
    text_t = Array.new
    total_text = Array.new
    text_1 = Hash.new
    text_1["Name"] = "ugooz.b2c.adviser.01.01"
    text_1["type"] = "text"
    text_1["text"] = "[[FULLNAME]]大大～根據你提供的會員資料，#{sta}吃#{con_option.name}，我推薦你喝「#{con_content[0].intro}」最佳！"
    text_1["delay"] = "1"
    text_t << text_1
    text_2 = Hash.new
    text_2["Name"] = "ugooz.b2c.adviser.01.02"
    text_2["type"] = "image"
    text_2["url"] = con_content[0].pic
    text_2["delay"] = "1"
    text_t << text_2
    text_3 = Hash.new
    text_3["Name"] = "ugooz.b2c.adviser.01.03"
    text_3["type"] = "text"
    text_3["text"] = con_content[0].content
    text_3["delay"] = "1"
    text_t << text_3
    text_4 = Hash.new
    text_4["Name"] = "ugooz.b2c.adviser.01.04"
    text_4["type"] = "text"
    text_4["text"] = "查看其他餐點"
    text_4["delay"] = "1"
    text_t << text_4
    total_text << text_t
    card_t = Array.new
    cons.consultation_cates.limit(9).order(:sort).each_with_index do |ccat, i|
      card_s = Hash.new
      card_s["NAME"] = "ugooz.b2c.adviser.#{cons.id}.0#{total_text[0].size+1}.0#{i+1}"
      card_s["title"] = ccat.name
      card_s["image_url"] = ccat.pic
      button_t = Array.new
      ccat.consultation_options.limit(3).order(:sort).each do |copt|
        button_si = Hash.new
        button_si["type"] = "postback"
        button_si["title"] = copt.name
        button_si["payload"] = "u_#{cons.id}_#{copt.id}"
        button_t << button_si
      end
      card_s["buttons"] = button_t
      card_t << card_s
    end
    total_text << card_t
    render text: total_text
	end
end
