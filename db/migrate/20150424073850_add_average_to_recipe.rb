class AddAverageToRecipe < ActiveRecord::Migration
  def change
  	add_column :recipes, :stars, :integer
  	add_column :recipes, :marks, :integer
  	add_column :recipes, :average, :real
  end
end
