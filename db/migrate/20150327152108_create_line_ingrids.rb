class CreateLineIngrids < ActiveRecord::Migration
  def change
    create_table :line_ingrids do |t|

      t.timestamps null: false
    end
  end
end
