class BasketController < ApplicationController
	include CurrentCart
	before_action :set_cart, only: [:show]
	before_action :set_static, only: [:show]

	def show
		@basket = Basket.new(user_id: current_user.id)
		@cart.positions.each do |position|
			count = position.quantity
			position.recipe.line_ingrids.each do |line|
				current_ingridient = @basket.products.find_by(ingridient_id: line.ingridient.id)
					quantity = line.quantity
					measure = line.measure.id
					if line.measure.id == 2 or line.measure.id == 4
						quantity *= 1000
						measure -= 1
					end
					if current_ingridient
						current_ingridient.quantity += quantity * count
					else
						current_ingridient = @basket.products.build(ingridient_id: line.ingridient.id, measure_id: measure, quantity: quantity * count)
					end
			end
		end
	end
end