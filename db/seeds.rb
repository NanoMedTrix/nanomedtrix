if defined?( Spree::Core )
	puts " "
	puts "==  Spree::Core seeds ========================================================="
	Spree::Core::Engine.load_seed 
	puts "==  Spree::Core seeded ========================================================"
end

if defined?( Spree::Auth )
	puts " "
	puts "==  Spree::Auth seeds ========================================================="
	Spree::Auth::Engine.load_seed 
	puts "==  Spree::Auth seeded ========================================================"
end

unless ENV[ 'populate' ]
	puts " "
	ENV[ 'populate' ] = 'yes' if agree( 'Populate database? (yes/no)' )
end

if ENV[ 'populate' ]
	puts " "
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
	].each do | filename |
		file = File.join( File.dirname( __FILE__ ), 'seeds', "#{ filename }.rb" )
		puts "loading ruby #{ file } "
		require file
	end
	puts "==  Populated database ========================================================"
end
