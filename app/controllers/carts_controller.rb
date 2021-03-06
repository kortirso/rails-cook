class CartsController < ApplicationController
    before_filter :authenticate_user!
    include CurrentCart
    before_action :set_cart
    before_action :set_carts, only: [:show, :destroy]
    before_action :find_position, only: [:recipe_plus, :recipe_minus, :recipe_destroy]
    before_action :set_static
    rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

    def show
        if @current_cart.id == session[:cart_id]
            @positions = @current_cart.positions.includes(:recipe)
            render :show
        else
            redirect_to catalog_all_path
        end
    end

    def destroy
        if @current_cart.id == session[:cart_id]
            @current_cart.positions.destroy_all
            redirect_to @current_cart
        else
            redirect_to(catalog_all_path)
        end
    end

    def recipe_plus
        @position.update(quantity: @position.quantity + 1)
    end

    def recipe_minus
        @position.update(quantity: @position.quantity - 1) if @position.quantity > 1
    end

    def recipe_destroy
        @position.destroy
    end

    private
    def find_position
        @position = Position.find(params[:id])
    end

    def set_carts
        @current_cart = Cart.find(params[:id])
    end

    def invalid_cart
        redirect_to catalog_all_path
    end
end
