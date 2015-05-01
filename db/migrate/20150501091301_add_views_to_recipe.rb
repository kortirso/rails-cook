class AddViewsToRecipe < ActiveRecord::Migration
	def change
		add_column :recipes, :views, :integer
	end
end
