class BasketController < ApplicationController
	include CurrentCart
	before_action :set_cart, only: [:show]
	before_action :set_static, only: [:show]

	def show
		@basket = Basket.new(user_id: current_user.id)
	end
end