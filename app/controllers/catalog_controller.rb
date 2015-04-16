class CatalogController < ApplicationController
  before_action :set_static, except: [:index]

  def index # Главная страница
  end

  def all # Отображение всех рецептов
    @recipes = Recipe.where(visible: true)
    @h2 = "Все рецепты"
  end

  def category # Выборка рецептов по категориям
    category = Category.where('name = ?', params[:name]).take
    @recipes = Recipe.where('category_id = ?', category)
    @h2 = "Рецепты: " + category.caption
    render action: 'all'
  end

  def kitchen # Выборка рецептов по национальным кухням
    country = Country.where('name = ?', params[:name]).take
    @recipes = Recipe.where('country_id = ?', country)
    @h2 = "Рецепты: " + country.caption + " кухня"
    render action: 'all'
  end

  def show # Отображение определенного рецепта
    @recipe = Recipe.where('path_name = ?', params[:path_name]).take
    @list = LineIngrid.where(recipe_id: @recipe.id)
    @current_grade = Grade.where(recipe_id: @recipe.id, user_id: current_user.id).take if current_user
    @comment = Comment.new
  end
end
