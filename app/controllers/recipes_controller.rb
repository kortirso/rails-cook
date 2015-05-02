class RecipesController < ApplicationController
	before_action :set_static, only: [:new, :create]
	before_action :set_recipe, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!
	before_filter :set_accessible, except: [:new, :create]

	def index
		@recipes = Recipe.all
	end

	def show
	end

	def new
		@recipe = Recipe.new
		3.times do
			@recipe.line_ingrids.build
		end
		@recipe.steps.build
	end

	def edit
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.user_id = current_user.id
		@recipe.visible = false
		@recipe.stars = 0
		@recipe.marks = 0
		@recipe.average = 0.0
		respond_to do |format|
			if @recipe.save
				@recipe.line_ingrids.each do |z|
					z.recipe_id = @recipe.id
					z.save
				end
				@recipe.steps.each do |x|
					x.recipe_id = @recipe.id
					x.save
				end
				Notifier.recipe_new(@recipe).deliver_now
				format.html { redirect_to catalog_all_path, notice: 'Ваш рецепт появится в каталоге после модерации.' }
				format.json { render :show, status: :created, location: @recipe }
			else
				format.html { render :new }
				format.json { render json: @recipe.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @recipe.update(recipe_params)
				format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
				format.json { render :show, status: :ok, location: @recipe }
			else
				format.html { render :edit }
				format.json { render json: @recipe.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@recipe.destroy
		respond_to do |format|
			format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		def set_recipe
			@recipe = Recipe.find(params[:id])
		end

		def recipe_params
			params.require(:recipe).permit(:name, :category_id, :country_id, :caption, :user_id, :visible, :path_name, :image, :prepare, :portions, :stars, :marks, :average, line_ingrids_attributes: [:ingridient_id, :measure_id, :quantity, :id], steps_attributes: [:text, :id])
		end
end
