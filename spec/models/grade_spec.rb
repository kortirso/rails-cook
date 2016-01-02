RSpec.describe Grade, type: :model do
    it { should belong_to :recipe }
    it { should belong_to :user }
    it { should validate_presence_of :recipe_id }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :mark }
end