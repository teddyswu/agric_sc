module WorkProjectsHelper
	def render_is_farm_work(val)
		val == 1 ? "農場工作" : "採收處理"
	end

end
