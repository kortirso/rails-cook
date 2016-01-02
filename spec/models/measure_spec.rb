RSpec.describe Measure, type: :model do
    it { should have_many :line_ingrids }
    it { should have_many :products }
    it { should validate_presence_of :name }
end