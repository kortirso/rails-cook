class CatalogController < ApplicationController
    include CurrentCart
    before_action :set_cart
    before_action :set_static, except: [:index]

    def index # Главная страница
        session[:user_id] = User.find(current_user.id).id if current_user
        @recipes = Recipe.showed.order(created_at: :desc).limit(5)
    end

    def all # Отображение всех рецептов
        @recipes = Recipe.showed.order(created_at: :desc).includes(:user, :category, :country).page(params[:page]).per(10)
        @h2 = t('controllers.all')
    end

    def search
        @recipes = Recipe.showed.order(created_at: :desc).includes(:user, :category, :country)
        @recipes = @recipes.search_everywhere(params[:search][:query]) if params[:search][:query] != ""
        @recipes = @recipes.page(params[:page]).per(10)
        @h2 = t('controllers.search')
        render :all
    end

    def category # Выборка рецептов по категориям
        category = Category.find_by('name = ?', params[:name])
        if category
            @recipes = category.recipes.showed.order(created_at: :desc).page(params[:page]).per(10)
            @h2 = "#{t('controllers.recipes')}: #{category.caption}"
            render :all
        else
            render template: 'shared/403', status: 404
        end
    end

    def kitchen # Выборка рецептов по национальным кухням
        country = Country.find_by('name = ?', params[:name])
        if country
            @recipes = country.recipes.showed.order(created_at: :desc).page(params[:page]).per(10)
            @h2 = "#{t('controllers.recipes')}: #{country.caption} кухня"
            render :all
        else
            render template: 'shared/403', status: 404
        end
    end

    def show # Отображение определенного рецепта
        @recipe = Recipe.showed.find_by('path_name = ?', params[:path_name])
        if @recipe
            @recipe.update(views: @recipe.views + 1)
            @list = @recipe.line_ingrids.includes(:ingridient, :measure)
            @steps = @recipe.steps.order(id: :asc)
            @current_grade = @recipe.grades.find_by(user: current_user) if current_user
            @comments = @recipe.comments.order('id desc').includes(:user)
            @comment = Comment.new
            render :show
        else
            render template: 'shared/403', status: 404
        end
    end
end
