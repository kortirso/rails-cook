class CreateProducts < ActiveRecord::Migration
	def change
		create_table :products do |t|
			t.integer :ingridient_id
			t.integer :basket_id
			t.integer :measure_id
			t.integer :quantity
			t.timestamps null: false
		end
	end
end
