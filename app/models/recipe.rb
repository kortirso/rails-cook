class Recipe < ActiveRecord::Base
  validates :name, :category_id, :country_id, :caption, :steps, :prepare, :portions, :image, presence: true
  belongs_to :category
  belongs_to :country
  belongs_to :user
  has_many :positions
  has_many :carts, through: :positions
  has_many :comments
  has_many :line_ingrids
  accepts_nested_attributes_for :line_ingrids, allow_destroy: true
  has_many :ingridients, through: :line_ingrids
  has_many :grades
  mount_uploader :image, ImageUploader
end
