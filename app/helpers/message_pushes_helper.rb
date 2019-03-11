module MessagePushesHelper
	def render_purpose(purpose_num)
		return "B2B" if purpose_num == "1"
		return "B2C" if purpose_num == "2"
	end
end
