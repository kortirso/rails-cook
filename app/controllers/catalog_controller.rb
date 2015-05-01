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
		category = Category.where('name = ?', params[:name]).take
		@recipes = Recipe.where('category_id = ?', category).order(created_at: :desc).page(params[:page]).per(10)
		@h2 = "Рецепты: " + category.caption
		render action: 'all'
	end

	def kitchen # Выборка рецептов по национальным кухням
		country = Country.where('name = ?', params[:name]).take
		@recipes = Recipe.where('country_id = ?', country).order(created_at: :desc).page(params[:page]).per(10)
		@h2 = "Рецепты: " + country.caption + " кухня"
		render action: 'all'
	end

	def show # Отображение определенного рецепта
		@recipe = Recipe.where('path_name = ?', params[:path_name]).take
		if @recipe
			@recipe.update_attribute('views', @recipe.views + 1)
			@list = LineIngrid.where(recipe_id: @recipe.id)
			@current_grade = Grade.where(recipe_id: @recipe.id, user_id: current_user.id).take if current_user
			@comment = Comment.new
			render :show
		else
			render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
		end
	end
end
