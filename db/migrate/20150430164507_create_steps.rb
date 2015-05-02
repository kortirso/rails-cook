class CreateSteps < ActiveRecord::Migration
	def up
		remove_column :recipes, :steps
		create_table :steps do |t|
			t.text :text
			t.integer :recipe_id
			t.timestamps null: false
		end
	end
end
