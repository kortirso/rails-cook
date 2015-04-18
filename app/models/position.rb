class Position < ActiveRecord::Base
	belongs_to :recipe
	belongs_to :cart
end
