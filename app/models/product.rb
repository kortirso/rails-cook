class Product < ActiveRecord::Base
    belongs_to :ingridient
    belongs_to :basket
    belongs_to :measure

    validates :basket_id, :ingridient_id, :quantity, :measure_id, presence: true

    def reduce
        case self.measure.name
            when 'гр' then m = Measure.find_by(name: 'кг')
            when 'мл' then m = Measure.find_by(name: 'л')
        end
        self.update_attributes(quantity: self.quantity / 1000, measure: m)
    end
end
