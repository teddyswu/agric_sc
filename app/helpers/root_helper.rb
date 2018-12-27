module RootHelper
	def render_big_project_title(att, new_p)
		"<div class=\"text-center mb-3\"><div class=\"h1 font-weight-bold\">友善提案</div></div>".html_safe if att.size != 0 && new_p.size !=0
	end

	def render_att_project_title(att)
		"<li class=\"nav-item\"><a class=\"nav-link active\" data-toggle=\"tab\" href=\"#tab-project-hot\">關注提案</a></li>".html_safe if att.size != 0
	end

	def render_hot_project(att,new_p)
		"<li class=\"nav-item\"><a class=\"nav-link\" data-toggle=\"tab\" href=\"#tab-project-new\">最新提案</a></li>".html_safe if att.size != 0 && new_p.size !=0
		"<li class=\"nav-item\"><a class=\"nav-link active\" data-toggle=\"tab\" href=\"#tab-project-new\">最新提案</a></li>".html_safe if att.size == 0 && new_p.size !=0
	end
end
