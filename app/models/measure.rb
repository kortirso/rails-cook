class Measure < ActiveRecord::Base
    has_many :line_ingrids
    has_many :products

    validates :name, presence: true
end
