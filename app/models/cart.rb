class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :positions
  has_many :recipes, through: :positions
end
