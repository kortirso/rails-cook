describe CatalogController do
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
		it "show recipes from category" do
			get :category, name: 'soups'
			expect(response).to render_template :all
		end
		it "redirect to 404 when category not exist" do
			get :category, name: ''
			expect(response.status).to eq 404
		end
	end
	describe "kitchen action" do
		it "show recipes from kitchen" do
			get :kitchen, name: 'spanish'
			expect(response).to render_template :all
		end
		it "redirect to 404 when kitchen not exist" do
			get :kitchen, name: ''
			expect(response.status).to eq 404
		end
	end
	describe "show action" do
		it "show recipe if it exist" do
			get :show, path_name: 'cheesecake'
			expect(response).to render_template :show
		end
		it "redirect to 404 when recipe not exist" do
			get :show, path_name: ''
			expect(response.status).to eq 404
		end
	end
end