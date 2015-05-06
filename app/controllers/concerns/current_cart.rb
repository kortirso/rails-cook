module CurrentCart
	extend ActiveSupport::Concern

	private
		def set_cart
			@cart = Cart.find(session[:cart_id])
		rescue ActiveRecord::RecordNotFound
			if current_user
				old_cart = Cart.where(user_id: current_user.id).first
				if old_cart
					Position.where(cart_id: old_cart).each do |pos| # удаление всех связанных с предыдущей корзиной рецептов
						pos.destroy
					end
					old_cart.destroy # удаление предыдущей версии корзины
				end

				@cart = Cart.create(user_id: current_user.id)
				session[:cart_id] = @cart.id
			end
		end
end