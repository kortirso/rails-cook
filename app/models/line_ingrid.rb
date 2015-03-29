class LineIngrid < ActiveRecord::Base

  belongs_to :ingridient
  belongs_to :recipe

end
