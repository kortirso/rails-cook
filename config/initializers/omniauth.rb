Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
	provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
	provider :vkontakte, ENV['VKONTAKTE_KEY'], ENV['VKONTAKTE_SECRET']
	provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
	on_failure do |env|
		AuthenticationsController.action(:failure).call(env)
	end
end