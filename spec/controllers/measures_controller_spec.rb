RSpec.describe MeasuresController, type: :controller do
    describe 'GET #index' do
        it_behaves_like 'Not Admin'

        context 'for admin user' do
            let(:measures) { create_list(:measure, 2) }
            sign_in_admin
            before { get :index }

            it 'collect an array of all measures' do
                expect(assigns(:measures)).to match_array(measures)
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
        let(:measure) { create :measure }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :show, id: measure }

            it 'assigns a measure to @measure' do
                expect(assigns(:measure)).to eq measure
            end

            it 'renders index view' do
                expect(response).to render_template :show
            end
        end

        def do_request
            get :show, id: measure
        end
    end

    describe 'GET #new' do
        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :new }

            it 'assigns a new measure to @measure' do
                expect(assigns(:measure)).to be_a_new(Measure)
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
            it 'doesnt save the new measure in the DB' do
                expect { post :create, measure: attributes_for(:measure) }.to_not change(Measure, :count)
            end

            it 'redirect to users/sign_in' do
                post :create, measure: attributes_for(:measure)

                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'for logged user' do
            sign_in_user

            it 'doesnt save the new measure in the DB' do
                expect { post :create, measure: attributes_for(:measure) }.to_not change(Measure, :count)
            end

            it 'renders shared/403 with error' do
                post :create, measure: attributes_for(:measure)

                expect(response).to render_template 'shared/403'
            end
        end

        context 'for admin user' do
            sign_in_admin

            context 'with valid attributes' do
                it 'saves the new measure in the DB' do
                    expect { post :create, measure: attributes_for(:measure) }.to change(Measure, :count).by(1)
                end

                it 'redirects to show view' do
                    post :create, measure: attributes_for(:measure)

                    expect(response).to redirect_to measure_path(assigns(:measure))
                end
            end

            context 'with invalid attributes' do
                it 'does not save the new question in the DB' do
                    expect { post :create, measure: attributes_for(:measure, :invalid) }.to_not change(Measure, :count)
                end

                it 're-render new view' do
                    post :create, measure: attributes_for(:measure, :invalid)

                    expect(response).to render_template :new
                end
            end
        end
    end

    describe 'GET #edit' do
        let(:measure) { create :measure }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :edit, id: measure }

            it 'assigns a measure to @measure' do
                expect(assigns(:measure)).to eq measure
            end

            it 'renders edit view' do
                expect(response).to render_template :edit
            end
        end

        def do_request
            get :edit, id: measure
        end
    end

    describe 'PATCH #update' do
        let(:measure) { create :measure }

        context 'for guest user' do
            it 'cant change measure' do
                expect { patch :update, id: measure, measure: attributes_for(:measure) }.to_not change{measure}
            end

            it 'redirect to users/sign_in' do
                patch :update, id: measure, measure: attributes_for(:measure)

                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'for logged user' do
            sign_in_user

            it 'cant change measure' do
                expect { patch :update, id: measure, measure: attributes_for(:measure) }.to_not change{measure}
            end

            it 'renders shared/403 with error' do
                patch :update, id: measure, measure: attributes_for(:measure)

                expect(response).to render_template 'shared/403'
            end
        end

        context 'for admin user' do
            sign_in_admin

            context 'with valid data' do
                before { patch :update, id: measure, measure: { name: 'гр_new' } }

                it 'changes measure' do
                    measure.reload

                    expect(measure.name).to eq 'гр_new'
                end

                it 'and redirects to show view' do
                    expect(response).to redirect_to measure_path(assigns(:measure))
                end
            end

            context 'with invalid data' do
                it 'doesnt change measure' do
                    expect { patch :update, id: measure, measure: attributes_for(:measure, :invalid) }.to_not change(measure, :name)
                end

                it 'and re-render edit view' do
                    patch :update, id: measure, measure: attributes_for(:measure, :invalid)

                    expect(response).to render_template :edit
                end
            end
        end
    end

    describe 'POST #destroy' do
        let!(:measure) { create :measure }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin

            it 'deletes measure' do
                expect { delete :destroy, id: measure }.to change(Measure, :count).by(-1)
            end

            it 'redirects to measures path' do
                delete :destroy, id: measure

                expect(response).to redirect_to measures_path
            end
        end

        def do_request
            delete :destroy, id: measure
        end
    end
end
