module AgrisHelper
	def render_path(val)
		case val
		when /gif/
			"http://" + request.host + show_gif_path(val)
		when /jpg/
			"http://" + request.host + show_jpg_path(val)
		end
	end

	def render_enabled(enabled)
		case enabled
		when true
			"開啟"
		when false
			"關閉"
		end
	end
end
