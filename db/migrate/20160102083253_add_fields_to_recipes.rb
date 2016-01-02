class AddFieldsToRecipes < ActiveRecord::Migration
    def change
        add_column :recipes, :crockpot, :boolean, default: false
        add_column :recipes, :healthfood, :boolean, default: false
    end
end
