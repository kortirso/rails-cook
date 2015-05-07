Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '1625919904290443', '963ab344dd99c329cefa52b297a6e1eb'
	#provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
	provider :vkontakte, '4907951', 'O3RaDNEoIYhD9vb0Jwls', {:scope => 'email', :display => 'popup', :lang => 'en'}
	#provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end