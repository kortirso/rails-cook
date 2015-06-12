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
		it "redirect to 404 when category not exist" do
			get :category, name: ''
			expect(response.status).to eq 404
		end
	end
	describe "kitchen action" do
		it "redirect to 404 when kitchen not exist" do
			get :kitchen, name: ''
			expect(response.status).to eq 404
		end
	end
	describe "show action" do
		it "redirect to 404 when recipe not exist" do
			get :show, path_name: ''
			expect(response.status).to eq 404
		end
	end
end