class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  before_action :deny_ip

  def after_sign_in_path_for(resource_or_scope)
  	current_user.is_admin == true ? agris_path : root_path
  end
  def is_admin
    if current_user.is_admin != true
      flash[:alert] = "您無此權限, 請洽詢相關工作人員"
      redirect_to root_path
    end
  end

  def deny_ip
    deny_ip = ["41.44.109.146", "72.89.36.208","103.228.110.123"]
    render_404 if deny_ip.include?(request.remote_ip)
  end
end
