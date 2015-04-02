class AddColumnsToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :prepare, :integer
    add_column :recipes, :portions, :integer
  end
end
