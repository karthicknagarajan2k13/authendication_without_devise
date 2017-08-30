class SessionsController < ApplicationController
	skip_before_filter :user_authenticate!, only: [:new, :create]
	def new
	end
	def create
		@user = User.find_by_email(params[:email])
		if @user && @user.authenticate(params[:password])
			if @user.status == 'active'
				p 'session[:user_id] = @user.id'
				p session[:user_id] = @user.id
				redirect_to root_url, notice: 'Logged in!'
			else
				redirect_to root_url, notice: 'Your account is not active'
			end
		else
			render :new, notice: 'Invalid email & password'
		end
	end
	def destroy
		session[:user_id] = nil
		redirect_to root_url, notice: 'Logged out!'
	end
end
