module ParameterSetsHelper

	def render_role(role)
		case role
		when "subscribe_guest"
			"訂閱訪客"
		when "guest"
			"訪客"
		when "user"
			"會員"
		end
	end
end
