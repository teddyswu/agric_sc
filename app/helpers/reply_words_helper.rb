module ReplyWordsHelper
	def render_enabled(status)
		return status == true ? "開啟" : "關閉"
	end

	def render_datetime(date)
		return date.include?("2999") ? "永久" : date
	end
end
