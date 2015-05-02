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

	private
		def send_email_admin
			Notifier.user_new(self).deliver_now
		end
end
