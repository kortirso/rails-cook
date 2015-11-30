class Basket < ActiveRecord::Base
    belongs_to :user
    has_many :products
    has_many :ingridients, through: :products

    validates :user_id, presence: true
end
