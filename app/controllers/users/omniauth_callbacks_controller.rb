class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])
		if @user.persisted?
			sign_in_and_redirect catalog_path, :event => :authentication #this will throw if @user is not activated
			set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
		else
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
	end

	def vkontakte
		@user = User.from_omniauth(request.env["omniauth.auth"])
		if @user.persisted?
			sign_in_and_redirect catalog_path, :event => :authentication #this will throw if @user is not activated
			set_flash_message(:notice, :success, :kind => "Vkontakte") if is_navigational_format?
		else
			session["devise.vkontakte_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
	end

	def twitter
		@user = User.from_omniauth(request.env["omniauth.auth"])
		if @user.persisted?
			sign_in_and_redirect catalog_path, :event => :authentication #this will throw if @user is not activated
			set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
		else
			session["devise.twitter_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
	end

	def github
		@user = User.from_omniauth(request.env["omniauth.auth"])
		if @user.persisted?
			sign_in_and_redirect catalog_path, :event => :authentication #this will throw if @user is not activated
			set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
		else
			session["devise.github_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
	end
end