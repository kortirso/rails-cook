class AddColumnToLineingrid < ActiveRecord::Migration
  def change
    add_column :line_ingrids, :recipe_id, :integer
    add_column :line_ingrids, :ingridient_id, :integer
  end
end
