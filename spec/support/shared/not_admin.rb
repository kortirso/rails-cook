shared_examples_for 'Not Admin' do
    context 'for guest user' do
        it 'redirect to users/sign_in' do
            do_request

            expect(response).to redirect_to '/users/sign_in'
        end
    end

    context 'for logged user' do
        sign_in_user

        it 'renders layouts/403 with error' do
            do_request

            expect(response).to render_template 'layouts/403'
        end
    end
end