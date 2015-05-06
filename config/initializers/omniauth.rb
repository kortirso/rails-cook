Rails.application.config.middleware.use OmniAuth::Builder do
	#provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
	provider :facebook, '1625919904290443', '963ab344dd99c329cefa52b297a6e1eb'
	#provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
	#provider :vkontakte, ENV['VKONTAKTE_KEY'], ENV['VKONTAKTE_SECRET']
	#provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end