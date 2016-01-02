RSpec.describe Cart, type: :model do
    it { should belong_to :user }
    it { should have_many :positions }
    it { should have_many(:recipes).through(:positions) }
    it { should validate_presence_of :user_id }

    describe '.add_recipe' do

    end
end