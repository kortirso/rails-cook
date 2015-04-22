class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    # Доступ к редактированию структуры сайта имеет только пользователь с id == 1
    def set_accessible
      if current_user.id != 1
        render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
      end
    end

    def set_static
      @categories = Category.order('id').all
      @countries = Country.order('caption').all
    end
end
