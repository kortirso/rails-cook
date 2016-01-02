module FeatureMacros
    def sign_in(user)
        visit root_path
        click_on 'login'
        within '#login' do
            fill_in 'user_username', with: user.username
            fill_in 'user_password', with: user.password
            click_on 'Вход'
        end
    end
end