module FarmersHelper
	def render_tag(url)
		if url.downcase.include?("jp") 
			return image_tag url , class: "d-block w-100"
		else
			return "<video id=\"movie\" preload controls loop width=\"536\">
        <source src=\"#{url}\" type=\"video/mp4\" />
      </video>".html_safe
		end
	end

	def render_first_image(url)
		if url.downcase.include?("jp")
			return image_tag url, class: "img-fluid text-center"
		else
			return image_tag "https://i.imgur.com/BQnEqUW.png", class: "img-fluid text-center"
		end
	end

	def render_is_mobile_link(boo, id, record_id, i)
		if boo == true
			"<a class=\"position-relative d-block btn-info\" style=\"background-color:#fff\" href=\"#{farmer_mobile_img_path(id, record_id)}\">".html_safe
		else
			"<a class=\"position-relative d-block block-info\" style=\"background-color:#fff\" data-toggle=\"modal\" data-target=\"#modal-detail_#{i}\" href=\"javascript:void();\">".html_safe
		end
	end
end
