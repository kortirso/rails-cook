class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	skip_before_filter :authenticate_user!

	def self.provides_callback_for(provider)
		class_eval %Q{
			def #{provider}
				@user = User.find_for_oauth(env["omniauth.auth"], current_user)
				if @user.persisted?
					session[:user_id] = @user.id
					current_user = @user
					user_signed_in = true
					sign_in_and_redirect @user, event: :authentication
					set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
				else
					session["devise.#{provider}_data"] = env["omniauth.auth"]
					redirect_to new_user_registration_url
				end
			end
		}
	end

	[:twitter, :facebook, :vkontakte, :github, :yandex, :google_oauth2].each do |provider|
		provides_callback_for provider
	end
end