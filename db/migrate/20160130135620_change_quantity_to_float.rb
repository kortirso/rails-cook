class ChangeQuantityToFloat < ActiveRecord::Migration
    def change
        change_table :line_ingrids do |t|
            t.change :quantity, :float
        end
    end
end
