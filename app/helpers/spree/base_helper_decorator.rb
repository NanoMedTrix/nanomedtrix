module Spree
	module BaseHelper
		def link_to_cart( text = nil, css_class = nil )
			text = text ? h( text ) : Spree.t( 'cart' )	 

			if current_order.nil? or current_order.item_count.zero?
				order_count = "0"
			else
				order_count = "#{ current_order.item_count }"
			end

			text = "<span class=\"glyphicon glyphicon-shopping-cart\"></span> #{ text } <span class=\"badge\">#{ order_count }</span>".html_safe
			link_to text, spree.cart_path, class: css_class
		end

		def get_recently_viewed_products_ids
			( session[ 'recently_viewed_products' ] || '' ).split( ', ' )
		end

		def get_recently_viewed_products
			Spree::Product.find_by_array_of_ids( get_recently_viewed_products_ids )
		end
	end
end
