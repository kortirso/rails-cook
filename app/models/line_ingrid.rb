class LineIngrid < ActiveRecord::Base
    belongs_to :ingridient
    belongs_to :recipe
    belongs_to :measure

    validates :recipe_id, :ingridient_id, :quantity, :measure_id, presence: true
end
