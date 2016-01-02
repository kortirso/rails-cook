RSpec.describe Product, type: :model do
    it { should belong_to :ingridient }
    it { should belong_to :basket }
    it { should belong_to :measure }
    it { should validate_presence_of :ingridient_id }
    it { should validate_presence_of :basket_id }
    it { should validate_presence_of :measure_id }
    it { should validate_presence_of :quantity }
end