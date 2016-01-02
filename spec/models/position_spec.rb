RSpec.describe Position, type: :model do
    it { should belong_to :recipe }
    it { should belong_to :cart }
    it { should validate_presence_of :recipe_id }
    it { should validate_presence_of :cart_id }
    it { should validate_presence_of :quantity }
end