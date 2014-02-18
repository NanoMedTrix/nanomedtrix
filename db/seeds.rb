if defined?( Spree::Core )
	puts " "
	puts "==  Spree::Core ==============================================================="
	Spree::Core::Engine.load_seed 
	puts "==  Spree::Core ==============================================================="
end

puts " "
puts "==  Spree::Auth ==============================================================="
users = File.join( File.dirname( __FILE__ ), 'seeds', 'users.rb' )
require users
puts "==  Spree::Auth ==============================================================="

puts " "
puts "==  Google Analytics =========================================================="
ga = File.join( File.dirname( __FILE__ ), 'seeds', 'google_analytics.rb' )
puts "loading ruby #{ ga }"
require ga
puts "==  Google Analytics =========================================================="
puts " "

unless ENV[ 'populate' ]
	ENV[ 'populate' ] = 'yes' if agree( 'Populate database? (yes/no)' )
	puts " "
end

if ENV[ 'populate' ]
	puts "==  Populating database ======================================================="
	%w[
		payment_methods
		shipping_categories
		shipping_methods
		tax_categories
		tax_rates
		products
		taxonomies
		taxons 
		option_types
		option_values
		product_option_types
		product_properties
		prototypes 
		variants
		stock
		assets
		addresses
		orders
		payments
		pages
		news_articles
		banners
	].each do | filename |
		file = File.join( File.dirname( __FILE__ ), 'seeds', "#{ filename }.rb" )
		puts "loading ruby #{ file } "
		require file
	end
	puts "==  Populated database ========================================================"
	puts " "
end
