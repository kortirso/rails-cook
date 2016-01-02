class Cart < ActiveRecord::Base
    belongs_to :user
    has_many :positions
    has_many :recipes, through: :positions

    validates :user_id, presence: true

    def add_recipe(recipe)
        position = positions.find_by(recipe: recipe)
        if position
            position.update(quantity: position.quantity + 1)
        else
            position = positions.create(recipe: recipe)
        end
        position
    end
end
