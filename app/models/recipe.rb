class Recipe < ActiveRecord::Base
  validates :name, :category_id, :country_id, :caption, :steps, presence: true

  belongs_to :category
  belongs_to :country
  belongs_to :user
  has_many :positions
  has_many :carts, through: :positions
  has_many :comments
end
