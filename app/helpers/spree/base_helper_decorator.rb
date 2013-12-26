module Spree
	module BaseHelper
		def link_to_cart( text = nil )
			text = text ? h( text ) : Spree.t( 'cart' )	 

			if current_order.nil? or current_order.item_count.zero?
				order_count = "0"
			else
				order_count = "#{ current_order.item_count }"
			end

			text = "<span class=\"glyphicon glyphicon-shopping-cart\"></span> #{ text } <span class=\"badge\">#{ order_count }</span>".html_safe
			link_to text, spree.cart_path
		end
	end
end