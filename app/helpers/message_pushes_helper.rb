module MessagePushesHelper
	def render_purpose(purpose_num)
		return "正式B2B" if purpose_num == "1"
		return "正式B2C" if purpose_num == "2"
		return "測試B2B" if purpose_num == "3"
		return "測試B2C" if purpose_num == "4"
	end
end
