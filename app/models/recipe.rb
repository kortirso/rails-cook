class Recipe < ActiveRecord::Base
	validates :name, :category_id, :caption, :prepare, :portions, :image, presence: true
	belongs_to :category
	belongs_to :country
	belongs_to :user
	has_many :positions
	before_destroy :ensure_not_referenced_by_any_position
	has_many :carts, through: :positions
	has_many :comments
	has_many :line_ingrids
	accepts_nested_attributes_for :line_ingrids, allow_destroy: true
	has_many :ingridients, through: :line_ingrids
	has_many :grades
	mount_uploader :image, ImageUploader
	has_many :steps
	accepts_nested_attributes_for :steps, allow_destroy: true
	include PgSearch
	pg_search_scope :search_everywhere, against: [:name]

	private
		def ensure_not_referenced_by_any_position
			if positions.empty?
				return true
			else
				errors.add(:base, 'Существуют товарные позиции')
				return false
			end
		end
end
