Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '1625919904290443', '963ab344dd99c329cefa52b297a6e1eb'
	provider :twitter, 'JIXwbA4psHks7sVXUo6HWtf35', 'N2eg9WPWRYIil4Ky72z5vbUKu01eirISJjh8mBuSPjoPeapteo'
	provider :vkontakte, '4907951', 'O3RaDNEoIYhD9vb0Jwls', {:scope => 'friends,audio,photos,email', :display => 'popup',:lang => 'en',:image_size => 'original'}
	provider :github, '5b375012c94ce055559b', 'e54da31aeabfbb36dc1448dc6821096ee62b1e2e', scope: "user:email"
	provider :yandex, '1b8d079191444c05ae0ffdf2e2310c24', '0b5967933e1d4f4591221c5b8d15d201'
	provider :google_oauth2, '1038933763667-hangg0nrkberf7ektv0gvqbkr98nrig7.apps.googleusercontent.com', 'GMFBAskFYCSbSPAfTz93YMCC'
	provider :linkedin, '77nv1nwkvwuknc', 'fcJBkBHtj8f1xlEl'
	provider :instagram, 'ff4391c474b54bdfa8b63fab1ba4ccea', '6e2bf5f958824a18bdbcba3986382a7a'
	provider :odnoklassniki, '1136237312', '5AE27E1C0E19133D7C862C3F', :public_key => 'CBAMJKLEEBABABABA', :scope => 'VALUABLE_ACCESS'
end