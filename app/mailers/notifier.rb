class Notifier < ApplicationMailer

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.notifier.recipe_new.subject
    #
    def recipe_new(recipe)
        @recipe = recipe
        mail(to: "info@liptechsoft.ru", subject: "Добавлен новый рецепт - #{@recipe.name}")
    end

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.notifier.user_new.subject
    #
    def user_new(user)
        @user = user
        mail(to: "info@liptechsoft.ru", subject: "Добавлен новый пользователь")
    end
end
