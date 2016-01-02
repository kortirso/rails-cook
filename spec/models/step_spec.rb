RSpec.describe Step, type: :model do
    it { should belong_to :recipe }
    it { should validate_presence_of :recipe_id }
    it { should validate_presence_of :text }
end