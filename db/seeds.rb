if defined?( Spree::Core )
	puts "==  Spre::Core seeds =========================================================="
	Spree::Core::Engine.load_seed 
	puts "==  Spre::Core seeded ========================================================="
end

if defined?( Spree::Auth )
	puts " "
	puts "==  Spree::Auth seeds ========================================================="
	Spree::Auth::Engine.load_seed 
	puts "==  Spree::Auth seeded ========================================================"
end

puts " "
puts "==  Populating databases ======================================================"
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
].each do | filename |
	file = File.join( File.dirname( __FILE__ ), 'fake', "#{ filename }.rb" )
	puts "loading ruby #{ file } "
	require file
end
puts "==  Populated databases ======================================================="
