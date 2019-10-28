module ConsultationsHelper

	def render_age_rang(range)
		range == 4 ? "40歲以上" : "40歲以下"
	end

	def render_gender(gender)
		gender == 1 ? "男" : "女"
	end
end
