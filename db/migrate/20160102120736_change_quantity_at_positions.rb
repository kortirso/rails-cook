class ChangeQuantityAtPositions < ActiveRecord::Migration
    def change
        change_table :positions do |t|
            t.change :quantity, :integer, default: 1
        end
    end
end
