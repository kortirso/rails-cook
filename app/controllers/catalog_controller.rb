class CatalogController < ApplicationController
  def index # Главная страница
  end

  def all # Отображение всех рецептов
    @recipes = Recipe.all
    @h2 = "Все рецепты"
  end

  def category # Выборка рецептов по категориям
    @recipes = Recipe.where(category_id: params[:id])
    @categories = Category.find(params[:id])
    @h2 = "Рецепты: " + @categories.caption
    render action: 'all'
  end

  def kitchen # Выборка рецептов по национальным кухням
    @recipes = Recipe.where(country_id: params[:id])
    @countries = Country.find(params[:id])
    @h2 = "Рецепты: " + @countries.caption
    render action: 'all'
  end

  def show # Отображение определенного рецепта
    @recipe = Recipe.find(params[:id])
  end
end
