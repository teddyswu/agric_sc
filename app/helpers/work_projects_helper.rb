module WorkProjectsHelper
	def render_is_farm_work(val)
		val == 1 ? "農地耕作" : "採收後處理"
	end

end
