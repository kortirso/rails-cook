class BasketController < ApplicationController
    include CurrentCart
    before_action :set_cart
    before_action :set_static
    before_filter :authenticate_user!

    def show
        basket_old = Basket.where(user_id: current_user.id).first
        if basket_old
            Product.where(basket_id: basket_old).each do |pos|
                pos.destroy # удаление всех позиций в рассчитанной ингредиентной корзине
            end
            basket_old.destroy # удаление старого рассчета ингредиентов
        end
        basket = Basket.new(user_id: current_user.id)
        @cart.positions.each do |position|
            count = position.quantity
            position.recipe.line_ingrids.includes(:ingridient, :measure).each do |line|
                current_ingridient = basket.products.find_by(ingridient_id: line.ingridient.id)
                if line.measure.id == 2 or line.measure.id == 4 # перевод мер: кг => г и л => мл
                    line.quantity *= 1000
                    line.measure.id -= 1
                end
                if current_ingridient
                    current_ingridient.quantity += line.quantity.to_f * count
                else
                    current_ingridient = basket.products.build(ingridient_id: line.ingridient.id, measure_id: line.measure.id, quantity: line.quantity.to_f * count)
                end
            end
            basket.products.each do |x| # Если г и мл больше 1000, то сокращать запись
                if (x.measure_id == 1 or x.measure_id == 3) and x.quantity >= 1000
                    x.measure_id += 1
                    x.quantity /= 1000
                    x.quantity.round 3
                end
            end
        end
        basket.save
        @array = []
        basket.ingridients.order('name').all.each do |name| # формирование массива продуктовых позиций с сортировкой по имени ингредиента
            @array.push(basket.products.where(basket_id: basket, ingridient_id: name.id).take)
        end
        render :show
    end
end