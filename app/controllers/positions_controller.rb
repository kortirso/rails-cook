class PositionsController < ApplicationController
    include CurrentCart
    before_action :set_cart

    def create
        recipe = Recipe.find(params[:recipe_id])
        @cart.add_recipe(recipe) if recipe
    end

    private
    def position_params
        params.require(:position).permit(:recipe_id, :quantity)
    end
end
