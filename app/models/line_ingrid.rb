class LineIngrid < ActiveRecord::Base
  belongs_to :ingridient
  belongs_to :recipe
  belongs_to :measure
end
