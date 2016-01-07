class RecipesController < ApplicationController
    before_filter :authenticate_user!
    before_action :set_static, only: [:new, :create]
    before_action :set_recipe, only: [:show, :edit, :update, :destroy]
    before_filter :set_accessible, except: [:new, :create]

    def index
        @recipes = Recipe.includes(:category, :country).order('id desc')
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
            redirect_to catalog_all_path, flash: { manifesto_modal: true }
        else
            render :new
        end
    end

    def update
        @recipe.update(recipe_params) ? redirect_to(@recipe) : render(:edit)
    end

    def destroy
        @recipe.destroy
        redirect_to recipes_url
    end

    private
    def set_recipe
        @recipe = Recipe.find(params[:id])
    end

    def recipe_params
        params.require(:recipe).permit(:name, :category_id, :country_id, :caption, :user_id, :visible, :path_name, :image, :prepare, :portions, :stars, :marks, :average, :crockpot, :healthfood, line_ingrids_attributes: [:ingridient_id, :measure_id, :quantity, :id], steps_attributes: [:text, :id])
    end
end
