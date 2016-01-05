RSpec.describe CountriesController, type: :controller do
    describe 'GET #index' do
        it_behaves_like 'Not Admin'

        context 'for admin user' do
            let(:countries) { create_list(:country, 2) }
            sign_in_admin
            before { get :index }

            it 'collect an array of all countries' do
                expect(assigns(:countries)).to match_array(countries)
            end

            it 'renders index view' do
                expect(response).to render_template :index
            end
        end

        def do_request
            get :index
        end
    end

    describe 'GET #show' do
        let(:country) { create :country }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :show, id: country }

            it 'assigns a country to @country' do
                expect(assigns(:country)).to eq country
            end

            it 'renders index view' do
                expect(response).to render_template :show
            end
        end

        def do_request
            get :show, id: country
        end
    end

    describe 'GET #new' do
        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :new }

            it 'assigns a new country to @country' do
                expect(assigns(:country)).to be_a_new(Country)
            end

            it 'renders new view' do
                expect(response).to render_template :new
            end
        end

        def do_request
            get :new
        end
    end

    describe 'POST #create' do
        context 'for guest user' do
            it 'doesnt save the new country in the DB' do
                expect { post :create, country: attributes_for(:country) }.to_not change(Country, :count)
            end

            it 'redirect to users/sign_in' do
                post :create, country: attributes_for(:country)

                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'for logged user' do
            sign_in_user

            it 'doesnt save the new country in the DB' do
                expect { post :create, country: attributes_for(:country) }.to_not change(Country, :count)
            end

            it 'renders layouts/403 with error' do
                post :create, country: attributes_for(:country)

                expect(response).to render_template 'layouts/403'
            end
        end

        context 'for admin user' do
            sign_in_admin

            context 'with valid attributes' do
                it 'saves the new country in the DB' do
                    expect { post :create, country: attributes_for(:country) }.to change(Country, :count).by(1)
                end

                it 'redirects to show view' do
                    post :create, country: attributes_for(:country)

                    expect(response).to redirect_to country_path(assigns(:country))
                end
            end

            context 'with invalid attributes' do
                it 'does not save the new question in the DB' do
                    expect { post :create, country: attributes_for(:country, :invalid) }.to_not change(Country, :count)
                end

                it 're-render new view' do
                    post :create, country: attributes_for(:country, :invalid)

                    expect(response).to render_template :new
                end
            end
        end
    end

    describe 'GET #edit' do
        let(:country) { create :country }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :edit, id: country }

            it 'assigns a country to @country' do
                expect(assigns(:country)).to eq country
            end

            it 'renders edit view' do
                expect(response).to render_template :edit
            end
        end

        def do_request
            get :edit, id: country
        end
    end

    describe 'PATCH #update' do
        let(:country) { create :country }

        context 'for guest user' do
            it 'cant change country' do
                expect { patch :update, id: country, country: attributes_for(:country) }.to_not change{country}
            end

            it 'redirect to users/sign_in' do
                patch :update, id: country, country: attributes_for(:country)

                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'for logged user' do
            sign_in_user

            it 'cant change country' do
                expect { patch :update, id: country, country: attributes_for(:country) }.to_not change{country}
            end

            it 'renders layouts/403 with error' do
                patch :update, id: country, country: attributes_for(:country)

                expect(response).to render_template 'layouts/403'
            end
        end

        context 'for admin user' do
            sign_in_admin

            context 'with valid data' do
                before { patch :update, id: country, country: { name: 'test_country_new', caption: 'test country new' } }

                it 'changes country' do
                    country.reload

                    expect(country.name).to eq 'test_country_new'
                    expect(country.caption).to eq 'test country new'
                end

                it 'and redirects to show view' do
                    expect(response).to redirect_to country_path(assigns(:country))
                end
            end

            context 'with invalid data' do
                it 'doesnt change country' do
                    expect { patch :update, id: country, country: { name: '' } }.to_not change(country, :name)
                    expect { patch :update, id: country, country: { caption: '' } }.to_not change(country, :caption)
                end

                it 'and re-render edit view' do
                    patch :update, id: country, country: attributes_for(:country, :invalid)

                    expect(response).to render_template :edit
                end
            end
        end
    end

    describe 'POST #destroy' do
        let!(:country) { create :country }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin

            it 'deletes country' do
                expect { delete :destroy, id: country }.to change(Country, :count).by(-1)
            end

            it 'redirects to Countries path' do
                delete :destroy, id: country

                expect(response).to redirect_to countries_path
            end
        end

        def do_request
            delete :destroy, id: country
        end
    end
end
