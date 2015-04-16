class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
    	t.integer :user_id
    	t.integer :recipe_id
    	t.integer :mark

      t.timestamps null: false
    end
  end
end
