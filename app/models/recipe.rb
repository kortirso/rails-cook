class Recipe < ActiveRecord::Base
  belongs_to :category
  belongs_to :country
  has_many :positions
  has_many :carts, through: :positions
  has_many :comments
end
