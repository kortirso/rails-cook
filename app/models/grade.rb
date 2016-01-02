class Grade < ActiveRecord::Base
    belongs_to :recipe
    belongs_to :user

    validates :recipe_id, :user_id, :mark, presence: true
end
