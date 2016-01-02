class Position < ActiveRecord::Base
    belongs_to :recipe
    belongs_to :cart

    validates :quantity, :recipe_id, :cart_id, presence: true
end
