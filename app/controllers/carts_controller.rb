class CartsController < ApplicationController
	include CurrentCart
	before_action :set_cart, only: [:show, :destroy]
	after_action :set_cart, only: [:destroy]
	before_action :set_carts, only: [:show]
	rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
  end

  def destroy
  	@cart.destroy if @cart.id == session[:cart_id]
  	session[:cart_id] = nil
  	respond_to do |format|
  		format.html { redirect_to catalog_all_path }
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
