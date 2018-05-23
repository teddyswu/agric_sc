# -*- encoding : utf-8 -*-
module UserManagesHelper
	def render_is_true(is_admin)
		if is_admin == true
			return "是"
		else
			return "否"
		end
	end

	def render_is_farmer(a, b)
		if a == true && b == true
			return "是"
		else
			return "否"
		end
	end

	def render_row(filed_code)
		if filed_code.present?
			filed = ""
			filed_code.each do |code|
        filed << code.filed_code_name
        filed << "、"
			end
			return filed.chop
		else
			return text_field_tag 'filed_code[1]', nil, class: 'form-control'
		end
	end

end
