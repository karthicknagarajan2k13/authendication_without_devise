class UsersController < ApplicationController
	skip_before_filter :user_authenticate!, only: [:new, :create]
	def index
	end

	def new
		@user = User.new 
	end

	def create
		@user = User.new(user_params)
		if @user.save
			p @token = Digest::SHA1.hexdigest([Time.zone.now, rand].join)
			p @user.update_attributes(token: @token, status: 'active')
			p 'session[:user_id] = @user.id'
			p session[:user_id] = @user.id
			# UserMailer.email_confirmation(@user)
			redirect_to root_path
			flash[:notice] = "You signed up successfully"
			flash[:color]= "valid"
		else
			flash[:notice] = "Form is invalid"
			flash[:color]= "invalid"
			render :new
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation, :profile_image, :token, :status)
	end
end
