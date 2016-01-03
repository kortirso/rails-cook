RSpec.describe CatalogController, type: :controller do
    describe 'GET #index' do
        let(:recipes) { create_list(:recipe, 5, :visible) }
        before { get :index }

        it 'should show index page everytime' do
            expect(response).to render_template :index
        end

        it 'and collect an array of 5 recipes for slider' do
            expect(assigns(:recipes)).to match_array(recipes)
        end
    end

    describe 'GET #all' do
        let(:recipes) { create_list(:recipe, 5, :visible) }
        before { get :all }

        it 'should show recipes catalog when user go to catalog' do
            expect(response).to render_template :all
        end

        it 'and collect all recipes' do
            expect(assigns(:recipes)).to match_array(recipes)
        end
    end

    describe 'GET #category' do
        let(:category) { create :category }
        let(:recipes) { create_list(:recipe, 2, :visible, category: category) }

        context 'if category exists' do
            before { get :category, name: category.name }

            it 'it render template all' do
                expect(response).to render_template :all
            end

            it 'and collect recipes of this category' do
                expect(assigns(:recipes)).to match_array(recipes)
            end
        end

        it 'redirect to 404 when category not exist' do
            get :category, name: ''

            expect(response.status).to eq 404
        end
    end

    describe 'GET #kitchen' do
        let(:country) { create :country }
        let(:recipes) { create_list(:recipe, 2, :visible, country: country) }

        context 'if country exists' do
            before { get :kitchen, name: country.name }

            it 'it render template all' do
                expect(response).to render_template :all
            end

            it 'and collect recipes of this country' do
                expect(assigns(:recipes)).to match_array(recipes)
            end
        end

        it 'redirect to 404 when country not exist' do
            get :kitchen, name: ''

            expect(response.status).to eq 404
        end
    end

    describe 'GET #show' do
        let!(:recipe) { create :recipe, :visible }
        let!(:line_ingrids) { create_list(:line_ingrid, 2, recipe: recipe) }
        let!(:steps) { create_list(:step, 2, recipe: recipe) }
        let!(:comments) { create_list(:comment, 2, recipe: recipe) }

        context 'if recipe exists' do
            before { get :show, path_name: recipe.path_name }

            it 'it renders template show' do
                expect(response).to render_template :show
            end

            it 'and collect ingredients of recipe' do
                expect(assigns(:list)).to match_array(line_ingrids)
            end

            it 'and collect steps of recipe' do
                expect(assigns(:steps)).to match_array(steps)
            end

            it 'and collect comments of recipe' do
                expect(assigns(:comments)).to match_array(comments)
            end

            it 'and add +1 to view counter' do
                expect(Recipe.first.views).to eq 1
            end
        end

        it 'redirect to 404 when recipe not exist' do
            get :show, path_name: ''

            expect(response.status).to eq 404
        end
    end
end