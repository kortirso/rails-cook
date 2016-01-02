class CartsController < ApplicationController
    before_filter :authenticate_user!
    include CurrentCart
    before_action :set_cart
    before_action :set_carts, only: [:show]
    before_action :set_static
    rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

    def show
        if @current_cart.id != session[:cart_id]
            logger.error "Попытка доступа к чужой корзине  #{params[:id]} от пользователя #{current_user.id}"
            redirect_to catalog_all_path, notice: "Плохо пытаться ломиться в чужую продуктовую корзину"
        else
            render :show
        end
    end

    def destroy
        Position.where("cart_id = ?", @cart).each { |pos| pos.destroy } if @cart.id == session[:cart_id]
        redirect_to @cart
    end

    def recipe_plus
        @position = Position.where("id = ?", params[:position]).first
        @position.update_attribute('quantity', @position.quantity + 1)
        respond_to do |format|
            format.js
        end
    end

    def recipe_minus
        @position = Position.where("id = ?", params[:position]).first
        @position.update_attribute('quantity', @position.quantity - 1) if @position.quantity > 1
        respond_to do |format|
            format.js
        end
    end


    private
    def set_carts
        @current_cart = Cart.find(params[:id])
    end

    def invalid_cart
        logger.error "Попытка доступа к несуществующей корзине #{params[:id]}"
        redirect_to catalog_all_path, notice: "Несуществующая корзина"
    end
end
