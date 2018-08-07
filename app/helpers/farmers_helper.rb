module FarmersHelper
	def render_tag(url)
		if url.include?("jp") 
			return image_tag url , class: "img-fluid d-block"
		else
			return "<video id=\"movie\" preload controls loop width=\"536\">
        <source src=\"#{url}\" type=\"video/mp4\" />
      </video>".html_safe
		end
	end

	def render_first_image(url)
		if url.include?("jpg")
			return image_tag url, class: "img-fluid text-center"
		else
			return image_tag "https://i.imgur.com/BQnEqUW.png", class: "img-fluid text-center"
		end
	end
end
