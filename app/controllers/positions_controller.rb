class PositionsController < ApplicationController
    include CurrentCart
    before_action :set_cart

    def create
        recipe = Recipe.find(params[:recipe_id])
        @position = @cart.add_recipe(recipe)
        respond_to do |format|
            if @position.save
                format.html { redirect_to @position.cart }
                format.js
            else
                format.html { render action: 'new'}
            end
        end
    end

    private
    def position_params
        params.require(:position).permit(:recipe_id, :quantity)
    end
end
