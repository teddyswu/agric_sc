class AdvisoriesController < ApplicationController

	def index
		pl = params[:pl].split("_")
    cons = Consultation.find_by(:id => pl[1])
    total_text = Array.new
    case pl[2]
    when "cont"
      card_t = Array.new
      cons.consultation_cates.limit(9).order(:sort).each_with_index do |ccat, i|
        card_s = Hash.new
        card_s["NAME"] = "ugooz.b2c.adviser.#{cons.id}.01.0#{i+1}"
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
    when "other"
      card_t = Array.new
      other_cons = Consultation.where(:enabled => true).where.not(:id => cons.id)
      other_cons.limit(9).each_with_index do |ccat, i|
        card_s = Hash.new
        card_s["NAME"] = "ugooz.b2c.adviser.#{cons.id}.01.0#{i+1}"
        card_s["title"] = ccat.title
        card_s["image_url"] = ccat.pic
        button_t = Array.new
        button_si = Hash.new
        button_si["type"] = "postback"
        button_si["title"] = ccat.button_name
        button_si["payload"] = "u_#{ccat.id}_start"
        button_t << button_si
        card_s["buttons"] = button_t
        card_t << card_s
      end
      total_text << card_t
    when "start"
      ua = UserAnalyze.new
      ua.uid = params[:uid] if params[:uid].present?
      cons = Consultation.find(pl[1])
      cons.id >= 10 ? ua.pl = "adviser.#{cons.id}" : ua.pl = "adviser.0#{cons.id}"
      ua.save!
      u = Authorization.find_by_uid(params[:uid])
      if cons.cat == 2
        week = ["日", "一", "二", "三", "四", "五", "六"][Date.today.wday]
        season = ["","冬","冬","春","春","春","夏","夏","夏","秋","秋","秋","冬"][Time.now.month]
        case Time.now.strftime('%H').to_i
        when 0..4
          sta = "晚上"
        when 5..12
          sta = "上午"
        when 13..18
          sta = "下午"
        when 19..23
          sta = "晚上"
        end
        auth = Authorization.find_by_uid(params[:uid])
        auth.user.user_profile.age_range > 4 ? current_age = 4 : current_age = 3
        cate = ConsultationCate.where(:consultation_id => cons.id, :name => "#{season}天")
        option = ConsultationOption.where(:consultation_cate_id => cate, :name => sta)
        con_content = ConsultationContent.where(:consultation_option_id => option, :age_range => current_age, :gender => auth.user.user_profile.gender )
        text_t = Array.new
        total_text = Array.new
        text_1 = Hash.new
        text_1["Name"] = "ugooz.b2c.adviser.01.01"
        text_1["type"] = "text"
        text_1["text"] = "#{season}天的週#{week}#{sta}，根據你提供的會員資料，我推薦你喝「#{con_content[0].intro}」唷！"
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
        text_3["delay"] = "5"
        text_t << text_3
        text_4 = Hash.new
        text_4["Name"] = "ugooz.b2c.adviser.01.03"
        text_4["type"] = "text"
        text_4["text"] = "你想知道你自己，或身邊的親朋好友，在什麼時間適合喝什麼茶嗎?"
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
      else
        total_text = JSON.parse(cons.json.gsub("=>",":"))
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
      end
    else
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
      con_option = ConsultationOption.find(pl[2])
      auth = Authorization.find_by_uid(params[:uid])
      auth.user.user_profile.age_range > 4 ? current_age = 4 : current_age = 3
      con_content = ConsultationContent.where(:consultation_option_id => pl[2], :age_range => current_age, :gender => auth.user.user_profile.gender )
      text_t = Array.new
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
      total_text << text_t
      button_li = Array.new
      bs = Hash.new
      bs["NAME"] = "ugooz.b2c.adviser.01.04"
      bs["template_type"] = "button"
      bs["text"] = "查看其他選擇？還是想進行其它的茶諮詢呢？"
      bs_b = Array.new
      bs_bs1 = Hash.new
      bs_bs1["type"] = "postback"
      bs_bs1["payload"] = "u_#{cons.id}_cont"
      bs_bs1["title"] = "其他選擇"
      bs_b << bs_bs1
      bs_bs2 = Hash.new
      bs_bs2["type"] = "postback"
      bs_bs2["payload"] = "u_#{cons.id}_other"
      bs_bs2["title"] = "其它的茶諮詢"
      bs_b << bs_bs2
      bs["buttons"] = bs_b
      button_li << bs
      total_text << button_li
    end
    render text: total_text
	end
end
