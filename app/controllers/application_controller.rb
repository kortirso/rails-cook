class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	before_filter :set_locale
	protect_from_forgery with: :exception

	rescue_from ActionController::RoutingError, with: :render_not_found

	def catch_404
		raise ActionController::RoutingError.new(params[:path])
	end

	private
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