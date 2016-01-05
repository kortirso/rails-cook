class Cart < ActiveRecord::Base
    belongs_to :user
    has_many :positions
    has_many :recipes, through: :positions

    validates :user_id, presence: true

    def add_recipe(id)
        if Recipe.find_by(id: id)
            position = positions.find_by(recipe_id: id)
            position ? position.update(quantity: position.quantity + 1) : positions.create(recipe_id: id)
        end
    end
end
