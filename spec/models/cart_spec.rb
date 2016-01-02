RSpec.describe Cart, type: :model do
    it { should belong_to :user }
    it { should have_many :positions }
    it { should have_many(:recipes).through(:positions) }
    it { should validate_presence_of :user_id }

    describe '.add_recipe' do
        let(:cart) { create :cart }
        let(:recipe) { create :recipe }

        it 'creates position in the cart' do
            expect { cart.add_recipe(recipe) }.to change(cart.positions, :count).by(1)
        end

        describe 'add recipe by second time' do
            before { create :position, recipe: recipe, cart: cart }

            it 'doesnot create new position in the cart' do
                expect { cart.add_recipe(recipe) }.to_not change(Position, :count)
            end

            it 'and add +1 to quantity of exists position' do
                cart.add_recipe(recipe)

                expect(cart.positions.first.quantity).to eq 2
            end
        end
    end
end