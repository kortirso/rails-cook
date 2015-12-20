class WelcomeController < ApplicationController
    def index
    end

    def locale
        params[:name] == 'ru' ? session[:locale] = 'ru' : session[:locale] = 'en'
        redirect_to catalog_all_path
    end
end
