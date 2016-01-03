class Product < ActiveRecord::Base
    belongs_to :ingridient
    belongs_to :basket
    belongs_to :measure

    validates :basket_id, :ingridient_id, :quantity, :measure_id, presence: true

    def reduce
        self.update(quantity: self.quantity / 1000.0, measure_id: self.measure_id + 1)
    end
end
