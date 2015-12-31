class AddDefaultsToRecipe < ActiveRecord::Migration
    def change
        change_table :recipes do |t|
            t.change :visible, :boolean, default: false
            t.change :stars, :integer, default: 0
            t.change :marks, :integer, default: 0
            t.change :average, :float, default: 0.0
            t.change :views, :integer, default: 0
        end
    end
end
