RSpec.describe LineIngrid, type: :model do
    it { should belong_to :ingridient }
    it { should belong_to :recipe }
    it { should belong_to :measure }
    it { should validate_presence_of :ingridient_id }
    it { should validate_presence_of :measure_id }
    it { should validate_presence_of :quantity }
end