class CategoriesController < ApplicationController
    before_filter :authenticate_user!
    before_action :set_category, only: [:show, :edit, :update, :destroy]
    before_filter :set_accessible

    def index
        @categories = Category.all
    end

    def show
    end

    def new
        @category = Category.new
    end

    def edit
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to @category
        else
            render :new
        end
    end

    def update
        if @category.update(category_params)
            redirect_to @category
        else
            render :edit
        end
    end

    def destroy
        @category.destroy
        redirect_to categories_url
    end

    private
    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name, :caption)
    end
end
