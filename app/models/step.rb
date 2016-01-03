class Step < ActiveRecord::Base
    belongs_to :recipe

    validates :text, presence: true
end
