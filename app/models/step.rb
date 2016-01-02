class Step < ActiveRecord::Base
    belongs_to :recipe

    validates :text, :recipe_id, presence: true
end
