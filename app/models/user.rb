class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	after_create :send_email_admin
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable
	has_one :cart
	has_many :comments
	has_many :recipes
	has_many :grades

	validates_presence_of :uid, :provider
	validates_uniqueness_of :uid, :scope => :provider

	private
		def send_email_admin
			Notifier.user_new(self).deliver_now
		end

		def self.from_omniauth(auth)
			where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
				user.email = auth.info.email
				user.password = Devise.friendly_token[0,20]
			end
		end

		def self.new_with_session(params, session)
			super.tap do |user|
				if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
					user.email = data["email"] if user.email.blank?
				end
			end
		end
end
