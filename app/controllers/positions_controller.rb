class PositionsController < ApplicationController
	include CurrentCart
	before_action :set_cart, only: [:create]

	def create
		recipe = Recipe.find(params[:recipe_id])
		@position = @cart.add_recipe(recipe.id)

		respond_to do |format|
			if @position.save
				format.html { redirect_to @position.cart }
				format.js
				format.json { render action: 'show', status: :created, location: @position}
			else
				format.html { render action: 'new'}
				format.json { render json: @position.errors, status: :unprocessable_entity }
			end
		end
	end

	private

		def position_params
			params.require(:position).permit(:recipe_id, :quantity)
		end
end
