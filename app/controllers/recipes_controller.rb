class RecipesController < ApplicationController
    before_filter :authenticate_user!
    before_action :set_static, only: [:new, :create]
    before_action :set_recipe, only: [:show, :edit, :update, :destroy]
    before_filter :set_accessible, except: [:new, :create]

    def index
        @recipes = Recipe.all
    end

    def show
    end

    def new
        @recipe = Recipe.new
        3.times { @recipe.line_ingrids.build }
        @recipe.steps.build
    end

    def edit
    end

    def create
        @recipe = Recipe.new(recipe_params.merge(user: current_user))
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
            redirect_to catalog_all_path, flash: { manifesto_modal: true }
        else
            render :new
        end
    end

    def update
        if @recipe.update(recipe_params)
            redirect_to @recipe, notice: 'Recipe was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @recipe.destroy
        redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
    end

    private
    def set_recipe
        @recipe = Recipe.find(params[:id])
    end

    def recipe_params
        params.require(:recipe).permit(:name, :category_id, :country_id, :caption, :user_id, :visible, :path_name, :image, :prepare, :portions, :stars, :marks, :average, :crockpot, :healthfood, line_ingrids_attributes: [:ingridient_id, :measure_id, :quantity, :id], steps_attributes: [:text, :id])
    end
end
