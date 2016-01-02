class CatalogController < ApplicationController
    include CurrentCart
    before_action :set_cart
    before_action :set_static, except: [:index]

    def index # Главная страница
        session[:user_id] = User.find(current_user.id).id if current_user
        @recipes = Recipe.where(visible: true).order(created_at: :desc).limit(5)
    end

    def all # Отображение всех рецептов
        @recipes = Recipe.where(visible: true).order(created_at: :desc).page(params[:page]).per(10)
        @h2 = t('controllers.all')
    end

    def search
        @recipes = Recipe.where(visible: true).order(created_at: :desc)
        @recipes = @recipes.search_everywhere(params[:search][:query]) if params[:search][:query] != ""
        @recipes = @recipes.page(params[:page]).per(10)
        @h2 = t('controllers.search')
        render :all
    end

    def category # Выборка рецептов по категориям
        category = Category.where('name = ?', params[:name]).first
        if category
            @recipes = Recipe.where(category_id: category.id, visible: true).order(created_at: :desc).page(params[:page]).per(10)
            @h2 = t('controllers.recipes') + ": " + category.caption
            render :all
        else
            render template: "layouts/403", status: 404
        end
    end

    def kitchen # Выборка рецептов по национальным кухням
        country = Country.where('name = ?', params[:name]).first
        if country
            @recipes = Recipe.where(country_id: country.id, visible: true).order(created_at: :desc).page(params[:page]).per(10)
            @h2 = t('controllers.recipes') + ": " + country.caption + " кухня"
            render :all
        else
            render template: "layouts/403", status: 404
        end
    end

    def show # Отображение определенного рецепта
        @recipe = Recipe.where('path_name = ?', params[:path_name]).first
        if @recipe
            @recipe.update_attribute('views', @recipe.views + 1)
            @list = LineIngrid.where(recipe_id: @recipe.id).includes(:ingridient, :measure)
            @steps = Step.where(recipe_id: @recipe.id).order(id: :asc)
            @current_grade = Grade.where(recipe_id: @recipe.id, user_id: current_user.id).first if current_user
            @comments = @recipe.comments.order('id').includes(:user)
            @comment = Comment.new
            render :show
        else
            render template: "layouts/403", status: 404
        end
    end
end
