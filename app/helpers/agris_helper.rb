module AgrisHelper
	def render_path(val)
		case val
		when /gif/
			"https://" + request.host + show_gif_path(val)
		when /jpg/
			"https://" + request.host + show_jpg_path(val)
		when /png/
			"https://" + request.host + show_png_path(val)
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

	def specify_keyword_type(kt)
		case kt
		when 1
			"輸入內容 含任一關鍵字"
		when 2
			"輸入內容 含所有關鍵字"
		when 3
			"輸入內容 完全相符"
		when 4
			"輸入類型 純文字"
		when 5
			"輸入類型 圖片"
		when 6
			"輸入類型 影片"
		when 7
			"輸入類型 音訊"
		when 8
			"輸入類型 位置"
		when 9
			"輸入格式 手機號碼"
		when 10
			"輸入格式 Email"
		when 11
			"輸入格式 數字"
		when 12
			"預設行為 任意輸入"
		end
	end

	def specify_keyword_role(role)
		case role
		when "subscribe_guest"
			"訂閱訪客"
		when "guest"
			"訪客"
		when "user"
			"會員"
		else
			"全部"
			
		end
	end
end
