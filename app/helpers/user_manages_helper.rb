# -*- encoding : utf-8 -*-
module UserManagesHelper
	def render_is_true(is_admin)
		if is_admin == true
			return "是"
		else
			return "否"
		end
	end
end
