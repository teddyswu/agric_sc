class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def after_sign_in_path_for(resource_or_scope)
  	current_user.is_admin == true ? agris_path : profile_users_path
  end
  def is_admin
    if current_user.is_admin != true
      flash[:alert] = "您無此權限, 請洽詢相關工作人員"
      redirect_to root_path
    end
  end
end
