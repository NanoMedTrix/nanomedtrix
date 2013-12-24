module Spree
	module BaseHelper
		def link_to_cart( text = nil )
			text = text ? h( text ) : Spree.t( 'cart' )	 
			text = "<span class=\"glyphicon glyphicon-shopping-cart\"></span> #{ text } <span class=\"badge\">#{ current_order.item_count }</span>".html_safe
				
			link_to text, spree.cart_path
		end
	end
end