class Ingridient < ActiveRecord::Base
	has_many :line_ingrids
	has_many :recipes, through: :line_ingrids
	before_destroy :ensure_not_referenced_by_any_line_ingrid
	mount_uploader :image, ImageUploader

	private

		def ensure_not_referenced_by_any_line_ingrid
			if line_ingrids.empty?
				return true
			else
				errors.add(:base, 'Существуют товарные позиции')
				return false
			end
		end

end
