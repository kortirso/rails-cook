class BasketController < ApplicationController
	include CurrentCart
	before_action :set_cart
	before_action :set_static

	def show
		@basket = Basket.new(user_id: current_user.id)
		@cart.positions.each do |position|
			count = position.quantity
			position.recipe.line_ingrids.each do |line|
				current_ingridient = @basket.products.find_by(ingridient_id: line.ingridient.id)
				if line.measure.id == 2 or line.measure.id == 4 # перевод мер: кг => г и л => мл
					line.quantity *= 1000
					line.measure.id -= 1
				end
				if current_ingridient
					current_ingridient.quantity += line.quantity * count
				else
					current_ingridient = @basket.products.build(ingridient_id: line.ingridient.id, measure_id: line.measure.id, quantity: line.quantity * count)
				end
			end
		end
	end
end