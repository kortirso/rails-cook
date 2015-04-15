class Grade < ActiveRecord::Base
	validates :recipe_id, :user_id, :grade, presence: true
  belongs_to :recipe
  belongs_to :user
end
