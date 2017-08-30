class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :user_authenticate!

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	helper_method :current_user

	def user_authenticate!
		unless current_user.present? 
			redirect_to root_path
		end
	end
end
