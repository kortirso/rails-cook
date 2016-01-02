class Basket < ActiveRecord::Base
    belongs_to :user
    has_many :products
    has_many :ingridients, through: :products

    validates :user_id, presence: true

    def refresh
        self.products.destroy_all
        Cart.find_by(user_id: self.user_id).positions.each do |position|
            count = position.quantity
            LineIngrid.where(recipe_id: position.recipe_id).each do |line|
                product = self.products.find_by(ingridient_id: line.ingridient_id)
                # перевод мер: кг => г и л => мл
                if line.measure_id == 2 || line.measure_id == 4
                    line.quantity *= 1000
                    line.measure_id -= 1
                end
                if product
                    product.quantity += line.quantity.to_f * count
                else
                    product = self.products.create(ingridient_id: line.ingridient_id, measure_id: line.measure_id, quantity: line.quantity.to_f * count)
                end
            end
        end
        self.reduce
        array = []
        self.ingridients.order('name').each { |ingridient| array.push(self.products.find_by(ingridient: ingridient)) }
        array
    end

    # Если г и мл больше 1000, то сокращать запись
    def reduce
        self.products.each do |x|
            if (x.measure_id == 1 || x.measure_id == 3) && x.quantity >= 1000
                x.measure_id += 1
                x.quantity /= 1000
                x.quantity.round 3
                x.save
            end
        end
    end
end
