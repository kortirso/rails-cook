RSpec.describe CategoriesController, type: :controller do
    describe 'GET #index' do
        it_behaves_like 'Not Admin'

        context 'for admin user' do
            let(:categories) { create_list(:category, 2) }
            sign_in_admin
            before { get :index }

            it 'collect an array of all categories' do
                expect(assigns(:categories)).to match_array(categories)
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
        let(:category) { create :category }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :show, id: category }

            it 'assigns a category to @category' do
                expect(assigns(:category)).to eq category
            end

            it 'renders index view' do
                expect(response).to render_template :show
            end
        end

        def do_request
            get :show, id: category
        end
    end

    describe 'GET #new' do
        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :new }

            it 'assigns a new category to @category' do
                expect(assigns(:category)).to be_a_new(Category)
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
            it 'doesnt save the new category in the DB' do
                expect { post :create, category: attributes_for(:category) }.to_not change(Category, :count)
            end

            it 'redirect to users/sign_in' do
                post :create, category: attributes_for(:category)

                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'for logged user' do
            sign_in_user

            it 'doesnt save the new category in the DB' do
                expect { post :create, category: attributes_for(:category) }.to_not change(Category, :count)
            end

            it 'renders layouts/403 with error' do
                post :create, category: attributes_for(:category)

                expect(response).to render_template 'layouts/403'
            end
        end

        context 'for admin user' do
            sign_in_admin

            context 'with valid attributes' do
                it 'saves the new category in the DB' do
                    expect { post :create, category: attributes_for(:category) }.to change(Category, :count).by(1)
                end

                it 'redirects to show view' do
                    post :create, category: attributes_for(:category)

                    expect(response).to redirect_to category_path(assigns(:category))
                end
            end

            context 'with invalid attributes' do
                it 'does not save the new question in the DB' do
                    expect { post :create, category: attributes_for(:category, :invalid) }.to_not change(Category, :count)
                end

                it 're-render new view' do
                    post :create, category: attributes_for(:category, :invalid)

                    expect(response).to render_template :new
                end
            end
        end
    end

    describe 'GET #edit' do
        let(:category) { create :category }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :edit, id: category }

            it 'assigns a category to @category' do
                expect(assigns(:category)).to eq category
            end

            it 'renders edit view' do
                expect(response).to render_template :edit
            end
        end

        def do_request
            get :edit, id: category
        end
    end

    describe 'PATCH #update' do
        let(:category) { create :category }

        context 'for guest user' do
            it 'cant change category' do
                expect { patch :update, id: category, category: attributes_for(:category) }.to_not change{category}
            end

            it 'redirect to users/sign_in' do
                patch :update, id: category, category: attributes_for(:category)

                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'for logged user' do
            sign_in_user

            it 'cant change category' do
                expect { patch :update, id: category, category: attributes_for(:category) }.to_not change{category}
            end

            it 'renders layouts/403 with error' do
                patch :update, id: category, category: attributes_for(:category)

                expect(response).to render_template 'layouts/403'
            end
        end

        context 'for admin user' do
            sign_in_admin

            context 'with valid data' do
                before { patch :update, id: category, category: { name: 'test_snacks_new', caption: 'test snacks new' } }

                it 'changes category' do
                    category.reload

                    expect(category.name).to eq 'test_snacks_new'
                    expect(category.caption).to eq 'test snacks new'
                end

                it 'and redirects to show view' do
                    expect(response).to redirect_to category_path(assigns(:category))
                end
            end

            context 'with invalid data' do
                it 'doesnt change category' do
                    expect { patch :update, id: category, category: { name: '' } }.to_not change(category, :name)
                    expect { patch :update, id: category, category: { caption: '' } }.to_not change(category, :caption)
                end

                it 'and re-render edit view' do
                    patch :update, id: category, category: attributes_for(:category, :invalid)

                    expect(response).to render_template :edit
                end
            end
        end
    end

    describe 'POST #destroy' do
        let!(:category) { create :category }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin

            it 'deletes category' do
                expect { delete :destroy, id: category }.to change(Category, :count).by(-1)
            end

            it 'redirects to categories path' do
                delete :destroy, id: category

                expect(response).to redirect_to categories_path
            end
        end

        def do_request
            delete :destroy, id: category
        end
    end
end
