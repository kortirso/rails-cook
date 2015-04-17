class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :positions
  has_many :recipes, through: :positions

  def add_recipe(recipe_id)
  	current_recipe = positions.find_by(recipe_id: recipe_id)
  	if current_recipe
  		current_recipe.quantity += 1
  	else
  		current_recipe = positions.build(recipe_id: recipe_id)
  	end
  	current_recipe
  end
end
