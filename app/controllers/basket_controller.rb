class BasketController < ApplicationController
    before_filter :authenticate_user!
    include CurrentCart
    before_action :set_cart
    before_action :set_static
    
    def show
        @basket = Basket.find_or_create_by(user: current_user).refresh
    end
end