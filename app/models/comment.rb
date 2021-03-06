class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :recipe

    validates :body, :recipe_id, :user_id, presence: true
end
