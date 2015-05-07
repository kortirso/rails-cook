Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '1625919904290443', '963ab344dd99c329cefa52b297a6e1eb'
	provider :twitter, 'JIXwbA4psHks7sVXUo6HWtf35', 'N2eg9WPWRYIil4Ky72z5vbUKu01eirISJjh8mBuSPjoPeapteo'
	provider :vkontakte, '4907951', 'O3RaDNEoIYhD9vb0Jwls', {:scope => 'email', :display => 'popup', :lang => 'en'}
	provider :github, '5b375012c94ce055559b', 'e54da31aeabfbb36dc1448dc6821096ee62b1e2e', scope: "user:email"
end