class Basket < ActiveRecord::Base
    belongs_to :user
    has_many :products
    has_many :ingridients, through: :products

    validates :user_id, presence: true

    def refresh
        self.products.destroy_all
        Cart.find_by(user_id: self.user_id).positions.each do |position|
            count = position.quantity
            LineIngrid.where(recipe_id: position.recipe_id).includes(:measure).each do |line|
                product = self.products.find_by(ingridient_id: line.ingridient_id)
                # перевод мер: кг => г и л => мл
                if line.measure.name == 'кг' || line.measure.name == 'л'
                    line.quantity *= 1000
                    line.measure_id -= 1
                end
                if product
                    product.update(quantity: product.quantity + line.quantity * count)
                else
                    product = self.products.create(ingridient_id: line.ingridient_id, measure_id: line.measure_id, quantity: line.quantity * count)
                end
            end
        end
        # Если г и мл больше 1000, то сокращать запись
        self.products.each { |x| x.reduce if (x.measure.name == 'гр' || x.measure.name == 'мл') && x.quantity >= 1000 }
        array = []
        self.ingridients.order('name').each { |ingridient| array.push(self.products.where(ingridient: ingridient).take) }
        array
    end
end
