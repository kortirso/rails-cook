class Comment < ActiveRecord::Base
	validates :body, :recipe_id, :user_id, presence: true
	belongs_to :user
	belongs_to :recipe
end
