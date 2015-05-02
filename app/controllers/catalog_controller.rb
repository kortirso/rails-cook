class CatalogController < ApplicationController
	include CurrentCart
	before_action :set_cart
	before_action :set_static, except: [:index]

	def index # Главная страница
	end

	def all # Отображение всех рецептов
		@recipes = Recipe.where(visible: true).order(created_at: :desc).page(params[:page]).per(10)
		@h2 = "Все рецепты"
	end

	def category # Выборка рецептов по категориям
		category = Category.where('name = ?', params[:name]).first
		if category
			@recipes = Recipe.where(category_id: category.id).order(created_at: :desc).page(params[:page]).per(10)
			@h2 = "Рецепты: " + category.caption
			render :all
		else
			rrender template: "layouts/403", status: 404
		end
	end

	def kitchen # Выборка рецептов по национальным кухням
		country = Country.where('name = ?', params[:name]).first
		if country
			@recipes = Recipe.where(country_id: country.id).order(created_at: :desc).page(params[:page]).per(10)
			@h2 = "Рецепты: " + country.caption + " кухня"
			render :all
		else
			render template: "layouts/403", status: 404
		end
	end

	def show # Отображение определенного рецепта
		@recipe = Recipe.where('path_name = ?', params[:path_name]).first
		if @recipe
			@recipe.update_attribute('views', @recipe.views + 1)
			@list = LineIngrid.where(recipe_id: @recipe.id)
			@current_grade = Grade.where(recipe_id: @recipe.id, user_id: current_user.id).first if current_user
			@comment = Comment.new
			render :show
		else
			render template: "layouts/403", status: 404
		end
	end
end
