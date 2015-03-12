class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :short
      t.integer :category_id
      t.integer :country_id
      t.string :photo
      t.text :caption
      t.text :steps
      t.integer :user_id
      t.boolean :visible

      t.timestamps null: false
    end
  end
end
