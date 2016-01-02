RSpec.describe Ingridient, type: :model do
    it { should have_many :line_ingrids }
    it { should have_many(:recipes).through(:line_ingrids) }
    it { should have_many :products }
    it { should have_many(:baskets).through(:products) }
    it { should validate_presence_of :name }
end