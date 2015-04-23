class AddColumnToLineIngrids < ActiveRecord::Migration
  def change
    add_column :line_ingrids, :measure_id, :integer
    add_column :line_ingrids, :quantity, :integer
  end
end
