class AddPathNameToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :path_name, :string
  end
end
