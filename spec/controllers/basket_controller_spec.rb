describe BasketController do
    describe "show action" do
        it "redirect to sign_in page when user not login" do
            get :show
            expect(response).to redirect_to('/users/sign_in')
        end
        it "should show basket when user login" do
            @current_user = create(:user)
            sign_in @current_user
            #current_basket = FactoryGirl.create(:basket, { user_id: @current_user.id })
            get :show
            expect(response).to render_template :show
        end
    end
end