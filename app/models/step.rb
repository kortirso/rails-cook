class Step < ActiveRecord::Base
    validates :text, presence: true
    belongs_to :recipe
end
