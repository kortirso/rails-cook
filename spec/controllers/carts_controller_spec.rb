describe CartsController do
    describe "show action" do
        it "redirect to /users/sign_in when user not login" do
            cart = create(:cart)
            get :show, id: cart.id
            expect(response).to redirect_to('/users/sign_in')
        end
        it "redirect to catalog/all when user login but it's not his cart" do
            user = create(:user)
            cart_of_user = create(:cart, {user_id: user.id})
            @current_user = create(:user)
            sign_in @current_user
            cart_of_current = create(:cart, {user_id: @current_user.id})
            session[:cart_id] = cart_of_current.id
            get :show, id: cart_of_user.id
            expect(response).to redirect_to(catalog_all_path)
        end
        it "should show cart when user login" do
            @current_user = create(:user)
            sign_in @current_user
            cart_of_current = create(:cart, {user_id: @current_user.id})
            session[:cart_id] = cart_of_current.id
            get :show, id: cart_of_current.id
            expect(response).to render_template :show
        end
    end
end