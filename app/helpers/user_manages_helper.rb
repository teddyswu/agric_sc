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
			filed_code.each_with_index do |code, i|
				i = i+1
				filed <<"<input type='text' name='filed_code[#{i}]' id='filed_code_#{i}' value='#{code.filed_code_name}' class='form-control'>"
			end
			return filed.html_safe
		else
			return text_field_tag 'filed_code[1]', nil, class: 'form-control'
		end
	end

end
