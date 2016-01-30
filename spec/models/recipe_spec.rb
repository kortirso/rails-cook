RSpec.describe Recipe, type: :model do
    it { should belong_to :category }
    it { should belong_to :country }
    it { should belong_to :user }
    it { should validate_presence_of :category_id }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :prepare }
    it { should validate_presence_of :portions }
    #it { should validate_presence_of :image }
    it { should have_many :positions }
    it { should have_many(:carts).through(:positions) }
    it { should have_many :comments }
    it { should have_many :line_ingrids }
    it { should have_many(:ingridients).through(:line_ingrids) }
    it { should have_many :grades }
    it { should have_many :steps }
    it { should validate_numericality_of(:prepare).is_greater_than(0) }
    it { should validate_numericality_of(:portions).is_greater_than(0) }
    it { should accept_nested_attributes_for :line_ingrids }
    it { should accept_nested_attributes_for :steps }
    #it { should validate_uniqueness_of :path_name }
end