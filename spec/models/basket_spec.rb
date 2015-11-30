RSpec.describe Basket, type: :model do
    it { should belong_to :user }
    it { should have_many :products }
    it { should have_many(:ingridients).through(:products) }
    it { should validate_presence_of :user_id }
end