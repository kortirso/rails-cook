class CartsController < ApplicationController
	include CurrentCart
	before_action :set_cart, only: [:show, :destroy]
	before_action :set_carts, only: [:show]
	before_action :set_static, only: [:show]
	rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

	def show
	end

	def destroy
		if @cart.id == session[:cart_id]
			Position.where("cart_id = ?", @cart).each do |pos|
				pos.destroy
			end
		end
		respond_to do |format|
			format.html { redirect_to @cart }
			format.json { head :no_content }
		end
	end

	private
		def set_carts
			@cart = Cart.find(params[:id])
		end

		def invalid_cart
			logger.error "Попытка доступа к несуществующей корзине #{params[:id]}"
			redirect_to catalog_all_path, notice: "Несуществующая корзина"
		end
end
