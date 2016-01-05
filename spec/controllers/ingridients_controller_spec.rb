RSpec.describe IngridientsController, type: :controller do
    describe 'GET #index' do
        it_behaves_like 'Not Admin'

        context 'for admin user' do
            let(:ingridients) { create_list(:ingridient, 2) }
            sign_in_admin
            before { get :index }

            it 'collect an array of all ingridients' do
                expect(assigns(:ingridients)).to match_array(ingridients)
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
        let(:ingridient) { create :ingridient }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :show, id: ingridient }

            it 'assigns a ingridient to @ingridient' do
                expect(assigns(:ingridient)).to eq ingridient
            end

            it 'renders index view' do
                expect(response).to render_template :show
            end
        end

        def do_request
            get :show, id: ingridient
        end
    end

    describe 'GET #new' do
        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :new }

            it 'assigns a new ingridient to @ingridient' do
                expect(assigns(:ingridient)).to be_a_new(Ingridient)
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
            it 'doesnt save the new ingridient in the DB' do
                expect { post :create, ingridient: attributes_for(:ingridient) }.to_not change(Ingridient, :count)
            end

            it 'redirect to users/sign_in' do
                post :create, ingridient: attributes_for(:ingridient)

                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'for logged user' do
            sign_in_user

            it 'doesnt save the new ingridient in the DB' do
                expect { post :create, ingridient: attributes_for(:ingridient) }.to_not change(Ingridient, :count)
            end

            it 'renders layouts/403 with error' do
                post :create, ingridient: attributes_for(:ingridient)

                expect(response).to render_template 'layouts/403'
            end
        end

        context 'for admin user' do
            sign_in_admin

            context 'with valid attributes' do
                it 'saves the new ingridient in the DB' do
                    expect { post :create, ingridient: attributes_for(:ingridient) }.to change(Ingridient, :count).by(1)
                end

                it 'redirects to show view' do
                    post :create, ingridient: attributes_for(:ingridient)

                    expect(response).to redirect_to ingridient_path(assigns(:ingridient))
                end
            end

            context 'with invalid attributes' do
                it 'does not save the new question in the DB' do
                    expect { post :create, ingridient: attributes_for(:ingridient, :invalid) }.to_not change(Ingridient, :count)
                end

                it 're-render new view' do
                    post :create, ingridient: attributes_for(:ingridient, :invalid)

                    expect(response).to render_template :new
                end
            end
        end
    end

    describe 'GET #edit' do
        let(:ingridient) { create :ingridient }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :edit, id: ingridient }

            it 'assigns a ingridient to @ingridient' do
                expect(assigns(:ingridient)).to eq ingridient
            end

            it 'renders edit view' do
                expect(response).to render_template :edit
            end
        end

        def do_request
            get :edit, id: ingridient
        end
    end

    describe 'PATCH #update' do
        let(:ingridient) { create :ingridient }

        context 'for guest user' do
            it 'cant change ingridient' do
                expect { patch :update, id: ingridient, ingridient: attributes_for(:ingridient) }.to_not change{ingridient}
            end

            it 'redirect to users/sign_in' do
                patch :update, id: ingridient, ingridient: attributes_for(:ingridient)

                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'for logged user' do
            sign_in_user

            it 'cant change ingridient' do
                expect { patch :update, id: ingridient, ingridient: attributes_for(:ingridient) }.to_not change{ingridient}
            end

            it 'renders layouts/403 with error' do
                patch :update, id: ingridient, ingridient: attributes_for(:ingridient)

                expect(response).to render_template 'layouts/403'
            end
        end

        context 'for admin user' do
            sign_in_admin

            context 'with valid data' do
                before { patch :update, id: ingridient, ingridient: { name: 'new' } }

                it 'changes ingridient' do
                    ingridient.reload

                    expect(ingridient.name).to eq 'new'
                end

                it 'and redirects to show view' do
                    expect(response).to redirect_to ingridient_path(assigns(:ingridient))
                end
            end

            context 'with invalid data' do
                it 'doesnt change ingridient' do
                    expect { patch :update, id: ingridient, ingridient: attributes_for(:ingridient, :invalid) }.to_not change(ingridient, :name)
                end

                it 'and re-render edit view' do
                    patch :update, id: ingridient, ingridient: attributes_for(:ingridient, :invalid)

                    expect(response).to render_template :edit
                end
            end
        end
    end

    describe 'POST #destroy' do
        let!(:ingridient) { create :ingridient }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin

            it 'deletes ingridient' do
                expect { delete :destroy, id: ingridient }.to change(Ingridient, :count).by(-1)
            end

            it 'redirects to ingridients path' do
                delete :destroy, id: ingridient

                expect(response).to redirect_to ingridients_path
            end
        end

        def do_request
            delete :destroy, id: ingridient
        end
    end
end
