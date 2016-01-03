RSpec.describe BasketController, type: :controller do
    describe 'GET #show' do
        it 'redirect to sign_in page when user not login' do
            get :show

            expect(response).to redirect_to('/users/sign_in')
        end
        
        context 'when user is login' do
            sign_in_user

            it 'should show basket when user login' do
                get :show

                expect(response).to render_template :show
            end
        end
    end
end