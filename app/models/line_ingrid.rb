class LineIngrid < ActiveRecord::Base
  validates :ingridient_id, :quantity, :measure_id, presence: true
  belongs_to :ingridient
  belongs_to :recipe
  belongs_to :measure
end
