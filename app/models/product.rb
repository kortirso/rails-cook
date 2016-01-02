class Product < ActiveRecord::Base
    belongs_to :ingridient
    belongs_to :basket
    belongs_to :measure

    validates :basket_id, :ingridient_id, :quantity, :measure_id, presence: true
end
