class PositionsController < ApplicationController
    before_filter :authenticate_user!
    include CurrentCart
    before_action :set_cart

    def create
        @cart.add_recipe(params[:recipe_id])
    end

    private
    def position_params
        params.require(:position).permit(:recipe_id, :quantity)
    end
end
