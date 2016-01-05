RSpec.describe PositionsController, type: :controller do
    describe 'POST #create' do
        let(:mark) { 5 }
        let!(:recipe) { create :recipe }

        it 'for guest user, positions not created' do
            expect { post :create, recipe_id: recipe.id, format: :js }.to_not change(Position, :count)
        end
        
        context 'for logged user' do
            sign_in_user
            let!(:cart) { create :cart, user: @current_user }
            before { session[:cart_id] = cart.id }

            it 'if recipe not exists, position not created' do
                expect { post :create, recipe_id: 100, format: :js }.to_not change(@current_user.cart.positions, :count)
            end

            it 'if position not exists, position create in current_user cart' do
                expect { post :create, recipe_id: recipe.id, format: :js }.to change(@current_user.cart.positions, :count).by(1)
                expect(@current_user.cart.positions.first.quantity).to eq 1
            end

            it 'if position exists, position get +1 to quantity' do
                create :position, cart_id: @current_user.cart.id, recipe_id: recipe.id

                post :create, recipe_id: recipe.id, format: :js

                expect(@current_user.cart.positions.first.quantity).to eq 2
            end
        end
    end
end