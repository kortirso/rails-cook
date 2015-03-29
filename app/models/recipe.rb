class Recipe < ActiveRecord::Base

  validates :name, :category_id, :country_id, :caption, :steps, presence: true
  #serialize :ings, ActiveRecord::Coders::Hstore

  belongs_to :category
  belongs_to :country
  belongs_to :user
  has_many :positions
  has_many :carts, through: :positions
  has_many :comments
  has_many :line_ingrids
  accepts_nested_attributes_for :line_ingrids
  has_many :ingridients, through: :line_ingrids

  mount_uploader :image, ImageUploader

end
