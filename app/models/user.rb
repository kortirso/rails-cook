class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :registerable, :recoverable, :rememberable, :trackable, :database_authenticatable, :validatable, :omniauthable, omniauth_providers: [:vkontakte, :facebook, :github, :instagram]

    has_one :cart
    has_many :identities
    has_many :comments
    has_many :recipes
    has_many :grades

    validates :username, presence: true, uniqueness: true, length: { in: 1..20 }

    def self.admin?(id)
        find(id).admin
    end

    private
    def self.find_for_oauth(auth)
        identity = Identity.find_for_oauth(auth)
        return identity.user if identity # если существует авторизация, то возвращает пользователя
        email = auth.info[:email]
        case auth.provider
            when 'facebook' then username = auth[:extra][:raw_info][:username]
            when 'vkontakte' then username = auth[:extra][:raw_info][:nickname]
            when 'github' then username = auth[:extra][:raw_info][:login]
            when 'instagram' then username = auth[:extra][:raw_info][:username]
        end
        user = User.find_by(email: email)
        if user
            if user.username == username
                user.identities.create(provider: auth.provider, uid: auth.uid)
            else
                return false
            end
        else
            if User.find_by(username: username)
                return false
            else
                user = User.create(username: username, email: email, password: Devise.friendly_token[0,20])
                user.identities.create(provider: auth.provider, uid: auth.uid)
            end
        end
        user
    end
end
