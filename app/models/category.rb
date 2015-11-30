class Category < ActiveRecord::Base
    has_many :recipes

    validates :name, :caption, presence: true
end
