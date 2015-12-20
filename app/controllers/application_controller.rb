class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_filter :set_locale
    protect_from_forgery with: :exception

    rescue_from ActionController::RoutingError, with: :render_not_found

    def catch_404
        raise ActionController::RoutingError.new(params[:path])
    end

    private
    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
        devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
    end

    # Доступ к редактированию структуры сайта имеет только пользователь с id == 1
    def set_accessible
        render template: "layouts/403", status: 403 if current_user.id != 1
    end

    def set_static
        @categories = Category.order('id').all
        @countries = Country.order('caption').all
    end

    def render_not_found
        render template: "layouts/403", status: 404
    end

    def set_locale
        session[:locale] == 'ru'  || session[:locale] == 'en' ? I18n.locale = session[:locale] : I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end
end