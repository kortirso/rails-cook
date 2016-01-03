RSpec.describe Basket, type: :model do
    it { should belong_to :user }
    it { should have_many :products }
    it { should have_many(:ingridients).through(:products) }
    it { should validate_presence_of :user_id }

    describe '.refresh' do
        let!(:ingridients) { create_list(:ingridient, 2) }
        let!(:measure_1) { create :measure, name: 'гр' }
        let!(:measure_2) { create :measure, name: 'кг' }
        let!(:recipe_1) { create :recipe, :visible }
        let!(:line_ingrid_1) { create :line_ingrid, recipe: recipe_1, ingridient: ingridients.first, measure: measure_1, quantity: 100 }
        let!(:line_ingrid_2) { create :line_ingrid, recipe: recipe_1, ingridient: ingridients.last, measure: measure_1, quantity: 1000 }
        let!(:recipe_2) { create :recipe, :visible }
        let!(:line_ingrid_3) { create :line_ingrid, recipe: recipe_2, ingridient: ingridients.first, measure: measure_1, quantity: 100 }
        let!(:line_ingrid_4) { create :line_ingrid, recipe: recipe_2, ingridient: ingridients.last, measure: measure_1, quantity: 100 }
        let!(:cart) { create :cart }
        let!(:position_1) { create :position, cart: cart, recipe: recipe_1, quantity: 1 }
        let!(:position_2) { create :position, cart: cart, recipe: recipe_2, quantity: 2 }
        let!(:basket) { create :basket, user: cart.user }

        it 'build array with ingridients' do
            array = basket.refresh

            expect(array.size).to eq 2
            expect(array[0].ingridient).to eq ingridients.first
            expect(array[0].quantity).to eq 300
            expect(array[0].measure.name).to eq measure_1.name
            expect(array[1].ingridient).to eq ingridients.last
            expect(array[1].quantity).to eq 1200
            expect(array[1].measure.name).to eq measure_1.name
        end
    end
end