module AgrisHelper
	def render_path(val)
		case val
		when /gif/
			"http://" + request.host + show_gif_path(val)
		when /jpg/
			"http://" + request.host + show_jpg_path(val)
		end
	end
end
