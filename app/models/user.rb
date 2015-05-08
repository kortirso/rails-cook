class User < ActiveRecord::Base
	TEMP_EMAIL_PREFIX = '@railscook'
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	after_create :send_email_admin
	devise :registerable, :recoverable, :rememberable, :trackable,
		:database_authenticatable, :omniauthable, :validatable, omniauth_providers: [:vkontakte, :facebook, :github, :twitter, :yandex, :google_oauth2]
	has_one :cart
	has_many :identities
	has_many :comments
	has_many :recipes
	has_many :grades

	private
		def send_email_admin
			Notifier.user_new(self).deliver_now
		end

		def self.find_for_oauth(auth, signed_in_resource = nil)
			identity = Identity.find_for_oauth(auth)
			user = signed_in_resource ? signed_in_resource : identity.user
			if user.nil?
				email = auth.info.email
				user = User.where(:email => email).first
				if user.nil?
					username = auth.info.nickname || auth.uid
					user = User.new(
						#name: auth.extra.raw_info.name,
						#username: auth.info.nickname || auth.uid,
						email: email ? email : "#{username}#{TEMP_EMAIL_PREFIX}-#{auth.provider}-#{auth.uid}.com",
						password: Devise.friendly_token[0,20]
					)
					user.save!
				end
			end
			if identity.user != user
				identity.user = user
				identity.save!
			end
			signed_in_resource = user
			user
		end
end
