RSpec.describe RecipesController, type: :controller do
    describe 'GET #index' do
        it_behaves_like 'Not Admin'

        context 'for admin user' do
            let(:recipes) { create_list(:recipe, 2) }
            sign_in_admin
            before { get :index }

            it 'collect an array of all recipes' do
                expect(assigns(:recipes)).to match_array(recipes)
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
        let(:recipe) { create :recipe }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :show, id: recipe }

            it 'assigns a recipe to @recipe' do
                expect(assigns(:recipe)).to eq recipe
            end

            it 'renders index view' do
                expect(response).to render_template :show
            end
        end

        def do_request
            get :show, id: recipe
        end
    end

    describe 'GET #new' do
        context 'for guest user' do
            it 'redirect to users/sign_in' do
                get :new

                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'for logged user' do
            sign_in_user
            before { get :new }

            it 'assigns a new recipe to @recipe' do
                expect(assigns(:recipe)).to be_a_new(Recipe)
            end

            it 'renders new view' do
                expect(response).to render_template :new
            end
        end
    end

    describe 'POST #create' do
        context 'for guest user' do
            it 'doesnt save the new measure in the DB' do
                expect { post :create, recipe: attributes_for(:recipe) }.to_not change(Recipe, :count)
            end

            it 'redirect to users/sign_in' do
                post :create, recipe: attributes_for(:recipe)

                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'for logged user' do
            let!(:category) { create :category }
            sign_in_user

            context 'with valid attributes' do
                it 'saves the new measure in the DB' do
                    expect { post :create, recipe: attributes_for(:recipe, category_id: category.id) }.to change(Recipe, :count).by(1)
                end

                it 'and it belongs to user' do
                    expect { post :create, recipe: attributes_for(:recipe, category_id: category.id) }.to change(@current_user.recipes, :count).by(1)
                end

                it 'redirects to recipe catalog' do
                    post :create, recipe: attributes_for(:recipe, category_id: category.id)

                    expect(response).to redirect_to catalog_all_path
                end
            end

            context 'with invalid attributes' do
                it 'does not save the new question in the DB' do
                    expect { post :create, recipe: attributes_for(:recipe, :invalid, category_id: category.id) }.to_not change(Recipe, :count)
                end

                it 're-render new view' do
                    post :create, recipe: attributes_for(:recipe, :invalid, category_id: category.id)

                    expect(response).to render_template :new
                end
            end
        end
    end

    describe 'GET #edit' do
        let(:recipe) { create :recipe }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin
            before { get :edit, id: recipe }

            it 'assigns a recipe to @recipe' do
                expect(assigns(:recipe)).to eq recipe
            end

            it 'renders edit view' do
                expect(response).to render_template :edit
            end
        end

        def do_request
            get :edit, id: recipe
        end
    end

    describe 'PATCH #update' do
        let(:recipe) { create :recipe }

        context 'for guest user' do
            it 'cant change recipe' do
                expect { patch :update, id: recipe, recipe: attributes_for(:recipe) }.to_not change{recipe}
            end

            it 'redirect to users/sign_in' do
                patch :update, id: recipe, recipe: attributes_for(:recipe)

                expect(response).to redirect_to '/users/sign_in'
            end
        end

        context 'for logged user' do
            sign_in_user

            it 'cant change recipe' do
                expect { patch :update, id: recipe, recipe: attributes_for(:recipe) }.to_not change{recipe}
            end

            it 'renders layouts/403 with error' do
                patch :update, id: recipe, recipe: attributes_for(:recipe)

                expect(response).to render_template 'layouts/403'
            end
        end

        context 'for admin user' do
            sign_in_admin

            context 'with valid data' do
                before { patch :update, id: recipe, recipe: { name: 'new' } }

                it 'changes recipe' do
                    recipe.reload

                    expect(recipe.name).to eq 'new'
                end

                it 'and redirects to show view' do
                    expect(response).to redirect_to recipe_path(assigns(:recipe))
                end
            end

            context 'with invalid data' do
                it 'doesnt change recipe' do
                    expect { patch :update, id: recipe, recipe: attributes_for(:recipe, :invalid) }.to_not change(recipe, :name)
                end

                it 'and re-render edit view' do
                    patch :update, id: recipe, recipe: attributes_for(:recipe, :invalid)

                    expect(response).to render_template :edit
                end
            end
        end
    end

    describe 'POST #destroy' do
        let!(:recipe) { create :recipe }

        it_behaves_like 'Not Admin'

        context 'for admin user' do
            sign_in_admin

            it 'deletes recipe' do
                expect { delete :destroy, id: recipe }.to change(Recipe, :count).by(-1)
            end

            it 'redirects to measures path' do
                delete :destroy, id: recipe

                expect(response).to redirect_to recipes_path
            end
        end

        def do_request
            delete :destroy, id: recipe
        end
    end
end
