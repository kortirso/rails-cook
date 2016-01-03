RSpec.describe CartsController, type: :controller do
    describe 'GET #show' do
        context 'when user isnt login' do
            let(:cart) { create :cart }

            it 'redirect to /users/sign_in when user not login' do
                get :show, id: cart.id
                
                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'when user is login' do
            sign_in_user
            let(:cart) { create :cart, user: @current_user }
            before { session[:cart_id] = cart.id }

            it 'redirect to catalog/all if its not his cart' do
                other_cart = create :cart

                get :show, id: other_cart.id

                expect(response).to redirect_to catalog_all_path
            end

            it 'should show his cart' do
                get :show, id: cart.id

                expect(response).to render_template :show
            end
        end
    end

    describe 'POST #destroy' do
        context 'when user isnt login' do
            let(:cart) { create :cart }

            it 'redirect to /users/sign_in when user not login' do
                delete :destroy, id: cart.id
                
                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'when user is login' do
            sign_in_user
            let(:cart) { create :cart, user: @current_user }
            before { session[:cart_id] = cart.id }

            it 'redirect to catalog/all if its not his cart' do
                other_cart = create :cart

                delete :destroy, id: other_cart.id

                expect(response).to redirect_to catalog_all_path
            end

            it 'should destroy his' do
                delete :destroy, id: cart.id

                expect(response).to redirect_to cart
            end
        end
    end

    describe 'POST #recipe_plus' do
        context 'when user isnt login' do
            let(:position) { create :position }

            it 'redirect to /users/sign_in when user not login' do
                post :recipe_plus, id: position.id
                
                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'when user is login' do
            sign_in_user
            let!(:cart) { create :cart, user: @current_user }
            let!(:position) { create :position, cart: cart, quantity: 1 }
            before { session[:cart_id] = cart.id }

            it 'should +1 to quantity in position' do
                post :recipe_plus, id: position.id, format: :js

                expect(cart.positions.first.quantity).to eq 2
            end
        end
    end

    describe 'POST #recipe_minus' do
        context 'when user isnt login' do
            let(:position) { create :position }

            it 'redirect to /users/sign_in when user not login' do
                post :recipe_minus, id: position.id
                
                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'when user is login' do
            sign_in_user
            let!(:cart) { create :cart, user: @current_user }
            let!(:position) { create :position, cart: cart, quantity: 2 }
            before { session[:cart_id] = cart.id }

            it 'should -1 to quantity in position' do
                post :recipe_minus, id: position.id, format: :js

                expect(cart.positions.first.quantity).to eq 1
            end

            it 'should be equal minimum 1 forever' do
                post :recipe_minus, id: position.id, format: :js
                post :recipe_minus, id: position.id, format: :js

                expect(cart.positions.first.quantity).to eq 1
            end
        end
    end

    describe 'POST #recipe_destroy' do
        context 'when user isnt login' do
            let(:position) { create :position }

            it 'redirect to /users/sign_in when user not login' do
                post :recipe_destroy, id: position.id
                
                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'when user is login' do
            sign_in_user
            let!(:cart) { create :cart, user: @current_user }
            let!(:position) { create :position, cart: cart, quantity: 2 }

            it 'should destroy position in the cart' do
                expect { post :recipe_destroy, id: position.id, format: :js }.to change(Position, :count).by(-1)
            end
        end
    end
end