class Basket < ActiveRecord::Base
	belongs_to :user
	has_many :products
	has_many :ingridients, through: :products
end
