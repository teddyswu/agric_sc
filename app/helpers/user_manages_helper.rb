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

end
