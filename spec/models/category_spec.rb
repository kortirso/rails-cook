RSpec.describe Category, type: :model do
    it { should have_many :recipes }
    it { should validate_presence_of :name }
    it { should validate_presence_of :caption }
end