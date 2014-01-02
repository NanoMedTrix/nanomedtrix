Spree::Core::Engine.load_seed if defined?( Spree::Core )
Spree::Auth::Engine.load_seed if defined?( Spree::Auth )

puts " "
puts "Seeding databases... "
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
].each do | fake_seed_file |
	print "     loading #{ fake_seed_file.titleize }... "
	require File.join( File.dirname( __FILE__ ), 'fake', "#{ fake_seed_file }.rb" )
	puts "done."
end
