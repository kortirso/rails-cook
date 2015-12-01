RSpec.describe CatalogController, type: :controller do
    describe "index action" do
        it "should show index everytime" do
            get :index
            expect(response).to render_template :index
        end
    end

    describe "all action" do
        it "should show catalog/all when user go to catalog" do
            get :all
            expect(response).to render_template :all
        end
    end

    describe "category action" do
        let(:category) { create :category }

        it "show recipes from category" do
            get :category, name: category.name
            expect(response).to render_template :all
        end

        it "redirect to 404 when category not exist" do
            get :category, name: ''
            expect(response.status).to eq 404
        end
    end

    describe "kitchen action" do
        let(:country) { create :country }

        it "show recipes from kitchen" do
            get :kitchen, name: country.name
            expect(response).to render_template :all
        end

        it "redirect to 404 when kitchen not exist" do
            get :kitchen, name: ''
            expect(response.status).to eq 404
        end
    end

    describe "show action" do
        let(:recipe) { create :recipe, :visible }

        it "show recipe if it exist" do
            get :show, path_name: recipe.path_name
            expect(response).to render_template :show
        end

        it "redirect to 404 when recipe not exist" do
            get :show, path_name: ''
            expect(response.status).to eq 404
        end
    end
end