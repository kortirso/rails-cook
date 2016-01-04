class AddIndexesToTables < ActiveRecord::Migration
    def change
        add_index :baskets, :user_id
        add_index :carts, :user_id
        add_index :comments, :user_id
        add_index :comments, :recipe_id
        add_index :grades, :user_id
        add_index :grades, :recipe_id
        add_index :line_ingrids, :recipe_id
        add_index :line_ingrids, :ingridient_id
        add_index :line_ingrids, :measure_id
        add_index :positions, :recipe_id
        add_index :positions, :cart_id
        add_index :products, :measure_id
        add_index :products, :basket_id
        add_index :products, :ingridient_id
        add_index :recipes, :category_id
        add_index :recipes, :country_id
        add_index :recipes, :user_id
        add_index :steps, :recipe_id
    end
end
