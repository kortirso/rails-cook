class Product < ActiveRecord::Base
    validates :ingridient_id, :quantity, :measure_id, presence: true
    belongs_to :ingridient
    belongs_to :basket
    belongs_to :measure
end
