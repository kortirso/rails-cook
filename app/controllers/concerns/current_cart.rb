module CurrentCart
    extend ActiveSupport::Concern

    private
    def set_cart
        @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
        if current_user
            old_cart = Cart.find_by(user: current_user)
            if old_cart
                old_cart.positions.destroy_all
                old_cart.destroy
            end
            @cart = Cart.create(user: current_user)
            session[:cart_id] = @cart.id
        end
    end
end