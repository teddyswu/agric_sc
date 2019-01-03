module WorkDiariesHelper
	def render_position(position)
		case position
		when 1
			"大刊頭545*370"
		when 2
			"小矩形(277*190)"
		when 3
			"直條(277*380)"
		when 4
			"橫條(555*190)"
		end
	end

	def render_filter(filter)
		case filter
		when "contrast"
			"對比"
		when "saturate"
			"飽和"
		when "grayscale"
			"灰階"
		when "sepia"
			"懷舊"
		end
	end
end
