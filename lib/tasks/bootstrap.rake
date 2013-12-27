namespace :bootstrap do 
	desc "Load payment methods"
	task payment_methods: :environment do 
		print "Loading payment methods... "
		Spree::Gateway::Bogus.create!(
			{
				name: 'Credit Card',
				description: 'Bogus payment gateway for development.',
				environment: 'development',
				active: true
			}
		)

		Spree::Gateway::Bogus.create!(
			{
				name: 'Credit Card',
				description: 'Bogus payment gateway for production.',
				environment: 'production',
				active: true
			}
		)

		Spree::Gateway::Bogus.create!(
			{
				name: 'Credit Card',
				description: 'Bogus payment gateway for staging.',
				environment: 'staging',
				active: true
			}
		)

		Spree::Gateway::Bogus.create!(
			{
				name: 'Credit Card',
				description: 'Bogus payment gateway for test.',
				environment: 'test',
				active: true
			}
		)

		Spree::PaymentMethod::Check.create!(
			{
				name: 'Check',
				description: 'Pay by check.',
				active: true
			}
		)
		puts "done."
	end

	desc "Load shipping categories"
	task shipping_categories: :environment do 
		print "Loading shipping categories... "
		Spree::ShippingCategory.create!( name: 'Default' )
		puts "done."
	end

	desc "Load shipping methods"
	task shipping_methods: :environment do 
		print "Loading shipping methods... "
		begin
			north_america = Spree::Zone.find_by_name!( 'North America' )
		rescue ActiveRecord::RecordNotFound
			puts "Couldn't find 'North America' zone. Did you run `rake db:seed` first?"
			puts "That task will set up the countries, states and zones required for Spree."
		
			exit
		end

		europe_vat        = Spree::Zone.find_by_name!( 'EU_VAT' )
		shipping_category = Spree::ShippingCategory.find_or_create_by!( name: 'Default' )

		shipping_methods = [
			{
				name: 'UPS Ground (USD)',
				zones: [ north_america ],
				calculator: Spree::Calculator::Shipping::FlatRate.create!,
				shipping_categories: [ shipping_category ]
			},
			{
				name: 'UPS Two Day (USD)',
				zones: [ north_america ],
				calculator: Spree::Calculator::Shipping::FlatRate.create!,
				shipping_categories: [ shipping_category ]
			},
			{
				name: 'UPS One Day (USD)',
				zones: [ north_america ],
				calculator: Spree::Calculator::Shipping::FlatRate.create!,
				shipping_categories: [ shipping_category ]
			},
			{
				name: 'UPS Ground (EUR)',
				zones: [ europe_vat ],
				calculator: Spree::Calculator::Shipping::FlatRate.create!,
				shipping_categories: [ shipping_category ]
			}
		]

		shipping_methods.each do | shipping_method_attrs |
			Spree::ShippingMethod.create!( shipping_method_attrs )
		end

		{
			"UPS Ground (USD)" =>  [ 5, "USD" ],
			"UPS Ground (EUR)" =>  [ 5, "EUR" ],
			"UPS One Day (USD)" => [ 15, "USD" ],
			"UPS Two Day (USD)" => [ 10, "USD" ]
		}.each do | shipping_method_name, ( price, currency ) |
			shipping_method = Spree::ShippingMethod.find_by_name!( shipping_method_name )

			shipping_method.calculator.preferred_amount   = price
			shipping_method.calculator.preferred_currency = currency
			shipping_method.shipping_categories << Spree::ShippingCategory.first
			
			shipping_method.save!
		end
		puts "done."
	end

	desc "Load tax categories"
	task tax_categories: :environment do 
		print "Loading tax categories... "
		Spree::TaxCategory.create!(:name => "Clothing")
		Spree::TaxCategory.create!(:name => "Food")
		puts "done."
	end

	desc "Load tax rates"
	task tax_rates: :environment do 
		print "Loading tax rates... "
		north_america = Spree::Zone.find_by_name!("North America")
		clothing = Spree::TaxCategory.find_by_name!("Clothing")

		tax_rate = Spree::TaxRate.create(
			:name => "North America",
			:zone => north_america, 
			:amount => 0.05,
			:tax_category => clothing
		)

		tax_rate.calculator = Spree::Calculator::DefaultTax.create!
		tax_rate.save!
		puts "done."
	end

	desc "Load products"
	task products: :environment do 
		print "Loading products... "
		clothing = Spree::TaxCategory.find_by_name!("Clothing")
		shipping_category = Spree::ShippingCategory.find_by_name!("Default")

		default_attrs = {
			:description => Faker::Lorem.paragraph,
			:available_on => Time.zone.now
		}

		products = [
			{
				:name => "Ruby on Rails Tote",
				:tax_category => clothing,
				:shipping_category => shipping_category,
				:price => 15.99,
				:eur_price => 14,
			},
			{
				:name => "Ruby on Rails Bag",
				:tax_category => clothing,
				:shipping_category => shipping_category,
				:price => 22.99,
				:eur_price => 19,
			},
			{
				:name => "Ruby on Rails Baseball Jersey",
				:tax_category => clothing,
				:shipping_category => shipping_category,
				:price => 19.99,
				:eur_price => 16
			},
			{
				:name => "Ruby on Rails Jr. Spaghetti",
				:tax_category => clothing,
				:shipping_category => shipping_category,
				:price => 19.99,
				:eur_price => 16
			},
			{
				:name => "Ruby on Rails Ringer T-Shirt",
				:shipping_category => shipping_category,
				:tax_category => clothing,
				:price => 19.99,
				:eur_price => 16
			},
			{
				:name => "Ruby Baseball Jersey",
				:tax_category => clothing,
				:shipping_category => shipping_category,
				:price => 19.99,
				:eur_price => 16
			},
			{
				:name => "Apache Baseball Jersey",
				:tax_category => clothing,
				:shipping_category => shipping_category,
				:price => 19.99,
				:eur_price => 16
			},
			{
				:name => "Spree Baseball Jersey",
				:tax_category => clothing,
				:shipping_category => shipping_category,
				:price => 19.99,
				:eur_price => 16
			},
			{
				:name => "Spree Jr. Spaghetti",
				:tax_category => clothing,
				:shipping_category => shipping_category,
				:price => 19.99,
				:eur_price => 16
			},
			{
				:name => "Spree Ringer T-Shirt",
				:tax_category => clothing,
				:shipping_category => shipping_category,
				:price => 19.99,
				:eur_price => 16
			},
			{
				:name => "Spree Tote",
				:tax_category => clothing,
				:shipping_category => shipping_category,
				:price => 15.99,
				:eur_price => 14,
			},
			{
				:name => "Spree Bag",
				:tax_category => clothing,
				:shipping_category => shipping_category,
				:price => 22.99,
				:eur_price => 19
			},
			{
				:name => "Ruby on Rails Mug",
				:shipping_category => shipping_category,
				:price => 13.99,
				:eur_price => 12
			},
			{
				:name => "Ruby on Rails Stein",
				:shipping_category => shipping_category,
				:price => 16.99,
				:eur_price => 14
			},
			{
				:name => "Spree Stein",
				:shipping_category => shipping_category,
				:price => 16.99,
				:eur_price => 14,
			},
			{
				:name => "Spree Mug",
				:shipping_category => shipping_category,
				:price => 13.99,
				:eur_price => 12
			}
		]

		products.each do |product_attrs|
			eur_price = product_attrs.delete(:eur_price)
			Spree::Config[:currency] = "USD"

			default_shipping_category = Spree::ShippingCategory.find_by_name!("Default")
			product = Spree::Product.create!(default_attrs.merge(product_attrs))
			Spree::Config[:currency] = "EUR"
			product.reload
			product.price = eur_price
			product.shipping_category = default_shipping_category
			product.save!
		end

		Spree::Config[:currency] = "USD"
		puts "done."
	end

	desc "Load taxonomies"
	task taxonomies: :environment do 
		print "Loading taxonomies... "
		taxonomies = [
			{ :name => "Categories" },
			{ :name => "Brand" }
		]

		taxonomies.each do |taxonomy_attrs|
			Spree::Taxonomy.create!(taxonomy_attrs)
		end
		puts "done."
	end

	desc "Load taxons"
	task taxons: :environment do 
		print "Loading taxons... "
		categories = Spree::Taxonomy.find_by_name!("Categories")
		brands = Spree::Taxonomy.find_by_name!("Brand")

		products = { 
			:ror_tote => "Ruby on Rails Tote",
			:ror_bag => "Ruby on Rails Bag",
			:ror_mug => "Ruby on Rails Mug",
			:ror_stein => "Ruby on Rails Stein",
			:ror_baseball_jersey => "Ruby on Rails Baseball Jersey",
			:ror_jr_spaghetti => "Ruby on Rails Jr. Spaghetti",
			:ror_ringer => "Ruby on Rails Ringer T-Shirt",
			:spree_stein => "Spree Stein",
			:spree_mug => "Spree Mug",
			:spree_ringer => "Spree Ringer T-Shirt",
			:spree_baseball_jersey =>  "Spree Baseball Jersey",
			:spree_tote => "Spree Tote",
			:spree_bag => "Spree Bag",
			:spree_jr_spaghetti => "Spree Jr. Spaghetti",
			:apache_baseball_jersey => "Apache Baseball Jersey",
			:ruby_baseball_jersey => "Ruby Baseball Jersey"
		}

		products.each do |key, name|
			products[key] = Spree::Product.find_by_name!(name)
		end

		taxons = [
			{
				:name => "Categories",
				:taxonomy => categories,
				:position => 0
			},
			{
				:name => "Bags",
				:taxonomy => categories,
				:parent => "Categories",
				:position => 1,
				:products => [
					products[:ror_tote],
					products[:ror_bag],
					products[:spree_tote],
					products[:spree_bag]
				]
			},
			{
				:name => "Mugs",
				:taxonomy => categories,
				:parent => "Categories",
				:position => 2,
				:products => [
					products[:ror_mug],
					products[:ror_stein],
					products[:spree_stein],
					products[:spree_mug]
				]
			},
			{
				:name => "Clothing",
				:taxonomy => categories,
				:parent => "Categories" 
			},
			{
				:name => "Shirts",
				:taxonomy => categories,
				:parent => "Clothing",
				:position => 0,
				:products => [
					products[:ror_jr_spaghetti],
					products[:spree_jr_spaghetti]
				]
			},
			{
				:name => "T-Shirts",
				:taxonomy => categories,
				:parent => "Clothing" ,
				:products => [
					products[:ror_baseball_jersey],
					products[:ror_ringer],
					products[:apache_baseball_jersey],
					products[:ruby_baseball_jersey],
					products[:spree_baseball_jersey],
					products[:spree_ringer]
				],
				:position => 0
			},
			{
				:name => "Brands",
				:taxonomy => brands
			},
			{
				:name => "Ruby",
				:taxonomy => brands,
				:parent => "Brand" 
			},
			{
				:name => "Apache",
				:taxonomy => brands,
				:parent => "Brand" 
			},
			{
				:name => "Spree",
				:taxonomy => brands,
				:parent => "Brand"
			},
			{
				:name => "Rails",
				:taxonomy => brands,
				:parent => "Brand"
			}
		]

		taxons.each do |taxon_attrs|
			if taxon_attrs[:parent]
				taxon_attrs[:parent] = Spree::Taxon.find_by_name!(taxon_attrs[:parent])
				Spree::Taxon.create!(taxon_attrs)
			end
		end
		puts "done."
	end

	desc "Load option types"
	task option_types: :environment do 
		print "Loading option types... "
		Spree::OptionType.create!([
			{
				:name => "tshirt-size",
				:presentation => "Size",
				:position => 1
			},
			{
				:name => "tshirt-color",
				:presentation => "Color",
				:position => 2
			}
		])
		puts "done."
	end

	desc "Load option values"
	task option_values: :environment do 
		print "Loading option values... "
		size = Spree::OptionType.find_by_presentation!("Size")
		color = Spree::OptionType.find_by_presentation!("Color")

		Spree::OptionValue.create!([
			{
				:name => "Small",
				:presentation => "S",
				:position => 1,
				:option_type => size
			},
			{
				:name => "Medium",
				:presentation => "M",
				:position => 2,
				:option_type => size
			},
			{
				:name => "Large",
				:presentation => "L",
				:position => 3,
				:option_type => size
			},
			{
				:name => "Extra Large",
				:presentation => "XL",
				:position => 4,
				:option_type => size
			},
			{
				:name => "Red",
				:presentation => "Red",
				:position => 1,
				:option_type => color
			},
			{
				:name => "Green",
				:presentation => "Green",
				:position => 2,
				:option_type => color
			},
			{
				:name => "Blue",
				:presentation => "Blue",
				:position => 3,
				:option_type => color
			}
		])
		puts "done."
	end

	desc "Load product option types"
	task product_option_types: :environment do 
		print "Loading product option types... "
		size = Spree::OptionType.find_by_presentation!("Size")
		color = Spree::OptionType.find_by_presentation!("Color")

		ror_baseball_jersey = Spree::Product.find_by_name!("Ruby on Rails Baseball Jersey")
		ror_baseball_jersey.option_types = [size, color]
		ror_baseball_jersey.save!

		spree_baseball_jersey = Spree::Product.find_by_name!("Spree Baseball Jersey")
		spree_baseball_jersey.option_types = [size, color]
		spree_baseball_jersey.save!
		puts "done."
	end

	desc "Load product properties"
	task product_properties: :environment do 
		print "Loading product properties... "
		products =
		{ 
			"Ruby on Rails Baseball Jersey" => 
			{ 
				"Manufacturer" => "Wilson",
				"Brand" => "Wannabe Sports",
				"Model" => "JK1002",
				"Shirt Type" => "Baseball Jersey",
				"Sleeve Type" => "Long",
				"Made from" => "100% cotton",
				"Fit" => "Loose",
				"Gender" => "Men's"
			},
			"Ruby on Rails Jr. Spaghetti" =>
			{
				"Manufacturer" => "Jerseys",
				"Brand" => "Resiliance",
				"Model" => "TL174",
				"Shirt Type" => "Jr. Spaghetti T",
				"Sleeve Type" => "None",
				"Made from" => "90% Cotton, 10% Nylon",
				"Fit" => "Form",
				"Gender" => "Women's"
			},
			"Ruby on Rails Ringer T-Shirt" =>
			{
				"Manufacturer" => "Jerseys",
				"Brand" => "Conditioned",
				"Model" => "TL9002",
				"Shirt Type" => "Ringer T",
				"Sleeve Type" => "Short",
				"Made from" => "100% Vellum",
				"Fit" => "Loose",
				"Gender" => "Men's"
			},
			"Ruby on Rails Tote" =>
			{
				"Type" => "Tote",
				"Size" => %Q{15" x 18" x 6"},
				"Material" => "Canvas"
			},
			"Ruby on Rails Bag" =>
			{
				"Type" => "Messenger",
				"Size" => %Q{14 1/2" x 12" x 5"},
				"Material" => "600 Denier Polyester"
			},
			"Ruby on Rails Mug" => 
			{
				"Type" => "Mug",
				"Size" => %Q{4.5" tall, 3.25" dia.}
			},
			"Ruby on Rails Stein" =>
			{
				"Type" => "Stein",
				"Size" => %Q{6.75" tall, 3.75" dia. base, 3" dia. rim}
			},
			"Spree Stein" =>
			{
				"Type" => "Stein",
				"Size" => %Q{6.75" tall, 3.75" dia. base, 3" dia. rim}
			},
			"Spree Mug" => 
			{
				"Type" => "Mug",
				"Size" => %Q{4.5" tall, 3.25" dia.}
			},
			"Spree Tote" => 
			{
				"Type" => "Tote",
				"Size" => %Q{15" x 18" x 6"}
			},
			"Spree Bag" => 
			{
				"Type" => "Messenger",
				"Size" => %Q{14 1/2" x 12" x 5"}
			},
			"Spree Baseball Jersey" =>
			{
				"Manufacturer" => "Wilson",
				"Brand" => "Wannabe Sports",
				"Model" => "JK1002",
				"Shirt Type" => "Baseball Jersey",
				"Sleeve Type" => "Long",
				"Made from" => "100% cotton",
				"Fit" => "Loose",
				"Gender" => "Men's"
			},
			"Spree Jr. Spaghetti" =>
			{
				"Manufacturer" => "Jerseys",
				"Brand" => "Resiliance",
				"Model" => "TL174",
				"Shirt Type" => "Jr. Spaghetti T",
				"Sleeve Type" => "None",
				"Made from" => "90% Cotton, 10% Nylon",
				"Fit" => "Form",
				"Gender" => "Women's"
			},
			"Spree Ringer T-Shirt" =>
			{
				"Manufacturer" => "Jerseys",
				"Brand" => "Conditioned",
				"Model" => "TL9002",
				"Shirt Type" => "Ringer T",
				"Sleeve Type" => "Short",
				"Made from" => "100% Vellum",
				"Fit" => "Loose",
				"Gender" => "Men's"
			}
		}

		products.each do |name, properties|
			product = Spree::Product.find_by_name(name)
			
			properties.each do |prop_name, prop_value|
				product.set_property(prop_name, prop_value)
			end
		end
		puts "done."
	end

	desc "Load prototypes"
	task prototypes: :environment do 
		print "Loading prototypes... "
		prototypes = [
			{
				:name => "Shirt",
				:properties => ["Manufacturer", "Brand", "Model", "Shirt Type", "Sleeve Type", "Material", "Fit", "Gender"]
			},
			{
				:name => "Bag",
				:properties => ["Type", "Size", "Material"]
			},
			{
				:name => "Mugs",
				:properties => ["Size", "Type"]
			}
		]

		prototypes.each do |prototype_attrs|
			prototype = Spree::Prototype.create!(:name => prototype_attrs[:name])
		
			prototype_attrs[:properties].each do |property|
				prototype.properties << Spree::Property.find_by_name!(property)
			end
		end
		puts "done."
	end

	desc "Load variants"
	task variants: :environment do 
		print "Loading variants... "
		ror_baseball_jersey = Spree::Product.find_by_name!("Ruby on Rails Baseball Jersey")
		ror_tote = Spree::Product.find_by_name!("Ruby on Rails Tote")
		ror_bag = Spree::Product.find_by_name!("Ruby on Rails Bag")
		ror_jr_spaghetti = Spree::Product.find_by_name!("Ruby on Rails Jr. Spaghetti")
		ror_mug = Spree::Product.find_by_name!("Ruby on Rails Mug")
		ror_ringer = Spree::Product.find_by_name!("Ruby on Rails Ringer T-Shirt")
		ror_stein = Spree::Product.find_by_name!("Ruby on Rails Stein")
		spree_baseball_jersey = Spree::Product.find_by_name!("Spree Baseball Jersey")
		spree_stein = Spree::Product.find_by_name!("Spree Stein")
		spree_jr_spaghetti = Spree::Product.find_by_name!("Spree Jr. Spaghetti")
		spree_mug = Spree::Product.find_by_name!("Spree Mug")
		spree_ringer = Spree::Product.find_by_name!("Spree Ringer T-Shirt")
		spree_tote = Spree::Product.find_by_name!("Spree Tote")
		spree_bag = Spree::Product.find_by_name!("Spree Bag")
		ruby_baseball_jersey = Spree::Product.find_by_name!("Ruby Baseball Jersey")
		apache_baseball_jersey = Spree::Product.find_by_name!("Apache Baseball Jersey")

		small = Spree::OptionValue.find_by_name!("Small")
		medium = Spree::OptionValue.find_by_name!("Medium")
		large = Spree::OptionValue.find_by_name!("Large")
		extra_large = Spree::OptionValue.find_by_name!("Extra Large")

		red = Spree::OptionValue.find_by_name!("Red")
		blue = Spree::OptionValue.find_by_name!("Blue")
		green = Spree::OptionValue.find_by_name!("Green")

		variants = [
			{
				:product => ror_baseball_jersey,
				:option_values => [small, red],
				:sku => "ROR-00001",
				:cost_price => 17
			},
			{
				:product => ror_baseball_jersey,
				:option_values => [small, blue],
				:sku => "ROR-00002",
				:cost_price => 17
			},
			{
				:product => ror_baseball_jersey,
				:option_values => [small, green],
				:sku => "ROR-00003",
				:cost_price => 17
			},
			{
				:product => ror_baseball_jersey,
				:option_values => [medium, red],
				:sku => "ROR-00004",
				:cost_price => 17
			},
			{
				:product => ror_baseball_jersey,
				:option_values => [medium, blue],
				:sku => "ROR-00005",
				:cost_price => 17
			},
			{
				:product => ror_baseball_jersey,
				:option_values => [medium, green],
				:sku => "ROR-00006",
				:cost_price => 17
			},
			{
				:product => ror_baseball_jersey,
				:option_values => [large, red],
				:sku => "ROR-00007",
				:cost_price => 17
			},
			{
				:product => ror_baseball_jersey,
				:option_values => [large, blue],
				:sku => "ROR-00008",
				:cost_price => 17
			},
			{
				:product => ror_baseball_jersey,
				:option_values => [large, green],
				:sku => "ROR-00009",
				:cost_price => 17
			},
			{
				:product => ror_baseball_jersey,
				:option_values => [extra_large, green],
				:sku => "ROR-00012",
				:cost_price => 17
			}
		]

		masters = {
			ror_baseball_jersey => {
				:sku => "ROR-001",
				:cost_price => 17
			},
			ror_tote => {
				:sku => "ROR-00011",
				:cost_price => 17
			},
			ror_bag => {
				:sku => "ROR-00012",
				:cost_price => 21
			},
			ror_jr_spaghetti => {
				:sku => "ROR-00013",
				:cost_price => 17
			},
			ror_mug => {
				:sku => "ROR-00014",
				:cost_price => 11
			},
			ror_ringer => {
				:sku => "ROR-00015",
				:cost_price => 17
			},
			ror_stein => {
				:sku => "ROR-00016",
				:cost_price => 15
			},
			apache_baseball_jersey => {
				:sku => "APC-00001",
				:cost_price => 17
			},
			ruby_baseball_jersey => {
				:sku => "RUB-00001",
				:cost_price => 17
			},
			spree_baseball_jersey => {
				:sku => "SPR-00001",
				:cost_price => 17
			},
			spree_stein => {
				:sku => "SPR-00016",
				:cost_price => 15
			},
			spree_jr_spaghetti => {
				:sku => "SPR-00013",
				:cost_price => 17
			},
			spree_mug => {
				:sku => "SPR-00014",
				:cost_price => 11
			},
			spree_ringer => {
				:sku => "SPR-00015",
				:cost_price => 17
			},
			spree_tote => {
				:sku => "SPR-00011",
				:cost_price => 13
			},
			spree_bag => {
				:sku => "SPR-00012",
				:cost_price => 21
			}
		}

		Spree::Variant.create!(variants)

		masters.each do |product, variant_attrs|
			product.master.update_attributes!(variant_attrs)
		end
		puts "done."
	end

	desc "Load stock"
	task stock: :environment do 
		print "Loading stock... "
		location = Spree::StockLocation.first_or_create! name: 'default'
		location.active = true
		location.country =  Spree::Country.where(iso: 'US').first
		location.save!

		Spree::Variant.all.each do |variant|
			variant.stock_items.each do |stock_item|
				Spree::StockMovement.create(:quantity => 10, :stock_item => stock_item)
			end
		end
		puts "done."
	end

	desc "Load assets"
	task assets: :environment do 
		puts "Loading assets... "
		products = {}
		products[:ror_baseball_jersey] = Spree::Product.find_by_name!("Ruby on Rails Baseball Jersey") 
		products[:ror_tote] = Spree::Product.find_by_name!("Ruby on Rails Tote")
		products[:ror_bag] = Spree::Product.find_by_name!("Ruby on Rails Bag")
		products[:ror_jr_spaghetti] = Spree::Product.find_by_name!("Ruby on Rails Jr. Spaghetti")
		products[:ror_mug] = Spree::Product.find_by_name!("Ruby on Rails Mug")
		products[:ror_ringer] = Spree::Product.find_by_name!("Ruby on Rails Ringer T-Shirt")
		products[:ror_stein] = Spree::Product.find_by_name!("Ruby on Rails Stein")
		products[:spree_baseball_jersey] = Spree::Product.find_by_name!("Spree Baseball Jersey")
		products[:spree_stein] = Spree::Product.find_by_name!("Spree Stein")
		products[:spree_jr_spaghetti] = Spree::Product.find_by_name!("Spree Jr. Spaghetti")
		products[:spree_mug] = Spree::Product.find_by_name!("Spree Mug")
		products[:spree_ringer] = Spree::Product.find_by_name!("Spree Ringer T-Shirt")
		products[:spree_tote] = Spree::Product.find_by_name!("Spree Tote")
		products[:spree_bag] = Spree::Product.find_by_name!("Spree Bag")
		products[:ruby_baseball_jersey] = Spree::Product.find_by_name!("Ruby Baseball Jersey")
		products[:apache_baseball_jersey] = Spree::Product.find_by_name!("Apache Baseball Jersey")


		def image(name, type="jpeg")
			images_path = Pathname.new(File.dirname(__FILE__)) + "images"
			path = images_path + "#{name}.#{type}"
			return false if !File.exist?(path)
			File.open(path)
		end

		images = {
			products[:ror_tote].master => [
				{
					:attachment => image("ror_tote")
				},
				{
					:attachment => image("ror_tote_back") 
				}
			],
			products[:ror_bag].master => [
				{
					:attachment => image("ror_bag")
				}
			],
			products[:ror_baseball_jersey].master => [
				{
					:attachment => image("ror_baseball")
				},
				{
					:attachment => image("ror_baseball_back")
				}
			],
			products[:ror_jr_spaghetti].master => [
				{
					:attachment => image("ror_jr_spaghetti")
				}
			],
			products[:ror_mug].master => [
				{
					:attachment => image("ror_mug")
				},
				{
					:attachment => image("ror_mug_back")
				}
			],
			products[:ror_ringer].master => [
				{
					:attachment => image("ror_ringer")
				},
				{
					:attachment => image("ror_ringer_back")
				}
			],
			products[:ror_stein].master => [
				{
					:attachment => image("ror_stein")
				},
				{
					:attachment => image("ror_stein_back")
				}
			],
			products[:apache_baseball_jersey].master => [
				{
					:attachment => image("apache_baseball", "png")
				}
			],
			products[:ruby_baseball_jersey].master => [
				{
					:attachment => image("ruby_baseball", "png")
				}
			],
			products[:spree_bag].master => [
				{
					:attachment => image("spree_bag")
				}
			],
			products[:spree_tote].master => [
				{
					:attachment => image("spree_tote_front")
				},
				{
					:attachment => image("spree_tote_back") 
				}
			],
			products[:spree_ringer].master => [
				{
					:attachment => image("spree_ringer_t")
				},
				{
					:attachment => image("spree_ringer_t_back") 
				}
			],
			products[:spree_jr_spaghetti].master => [
				{
					:attachment => image("spree_spaghetti")
				}
			],
			products[:spree_baseball_jersey].master => [
				{
					:attachment => image("spree_jersey")
				},
				{
					:attachment => image("spree_jersey_back") 
				}
			],
			products[:spree_stein].master => [
				{
					:attachment => image("spree_stein")
				},
				{
					:attachment => image("spree_stein_back") 
				}
			],
			products[:spree_mug].master => [
				{
					:attachment => image("spree_mug")
				},
				{
					:attachment => image("spree_mug_back") 
				}
			]
		}

		products[:ror_baseball_jersey].variants.each do |variant|
			color = variant.option_value("tshirt-color").downcase
			main_image = image("ror_baseball_jersey_#{color}", "png")
			variant.images.create!(:attachment => main_image)
			back_image = image("ror_baseball_jersey_back_#{color}", "png")

			if back_image
				variant.images.create!(:attachment => back_image)
			end
		end

		images.each do |variant, attachments|
			puts "Loading images for #{variant.name}"
			attachments.each do |attachment|
				variant.images.create!(attachment)
			end
		end
		puts "done."
	end

	desc "Load addresses"
	task addresses: :environment do 
		print "Loading addresses... "
		united_states = Spree::Country.find_by_name!("United States")
		new_york = Spree::State.find_by_name!("New York")

		# Billing address
		Spree::Address.create!(
			:firstname => Faker::Name.first_name,
			:lastname => Faker::Name.last_name,
			:address1 => Faker::Address.street_address,
			:address2 => Faker::Address.secondary_address,
			:city => Faker::Address.city,
			:state => new_york,
			:zipcode => 16804,
			:country => united_states,
			:phone => Faker::PhoneNumber.phone_number
		)

		#Shipping address
		Spree::Address.create!(
			:firstname => Faker::Name.first_name,
			:lastname => Faker::Name.last_name,
			:address1 => Faker::Address.street_address,
			:address2 => Faker::Address.secondary_address,
			:city => Faker::Address.city,
			:state => new_york,
			:zipcode => 16804,
			:country => united_states,
			:phone => Faker::PhoneNumber.phone_number
		)
		puts "done."
	end

	desc "Load orders"
	task orders: :environment do 
		print "Loading orders... "

		orders = []
		orders << Spree::Order.create!(
			:number => "R123456789",
			:email => "spree@example.com",
			:item_total => 150.95,
			:adjustment_total => 150.95,
			:total => 301.90,
			:shipping_address => Spree::Address.first,
			:billing_address => Spree::Address.last
		)

		orders << Spree::Order.create!(
			:number => "R987654321",
			:email => "spree@example.com",
			:item_total => 15.95,
			:adjustment_total => 15.95,
			:total => 31.90,
			:shipping_address => Spree::Address.first,
			:billing_address => Spree::Address.last
		)

		orders[0].line_items.create!(
			:variant => Spree::Product.find_by_name!("Ruby on Rails Tote").master,
			:quantity => 1,
			:price => 15.99
		)

		orders[1].line_items.create!(
			:variant => Spree::Product.find_by_name!("Ruby on Rails Bag").master,
			:quantity => 1,
			:price => 22.99
		)

		orders.each(&:create_proposed_shipments)

		orders.each do |order|
			order.state = "complete"
			order.completed_at = Time.now - 1.day
			order.save!
		end
		puts "done."
	end

	desc "Load adjustments"
	task adjustments: :environment do 
		print "Loading adjustments... "
		first_order = Spree::Order.find_by_number!("R123456789")
		last_order = Spree::Order.find_by_number!("R987654321")

		first_order.adjustments.create!(
			:amount => 0,
			:source => first_order,
			:originator => Spree::TaxRate.find_by_name!("North America"),
			:label => "Tax",
			:state => "open",
			:mandatory => true
		)

		last_order.adjustments.create!(
			:amount => 0,
			:source => last_order,
			:originator => Spree::TaxRate.find_by_name!("North America"),
			:label => "Tax",
			:state => "open",
			:mandatory => true
		)

		first_order.adjustments.create!(
			:amount => 0,
			:source => first_order,
			:originator => Spree::ShippingMethod.find_by_name!("UPS Ground (USD)"),
			:label => "Shipping",
			:state => "finalized",
			:mandatory => true
		)

		last_order.adjustments.create!(
			:amount => 0,
			:source => last_order,
			:originator => Spree::ShippingMethod.find_by_name!("UPS Ground (USD)"),
			:label => "Shipping",
			:state => "finalized",
			:mandatory => true
		)
		puts "done."
	end

	desc "Load payments"
	task payments: :environment do 
		print "Loading payments... "
		# create payments based on the totals since they can't be known in YAML (quantities are random)
		method = Spree::PaymentMethod.where(:name => 'Credit Card', :active => true).first

		# Hack the current method so we're able to return a gateway without a RAILS_ENV
		Spree::Gateway.class_eval do
			def self.current
				Spree::Gateway::Bogus.new
			end
		end

		# This table was previously called spree_creditcards, and older migrations
		# reference it as such. Make it explicit here that this table has been renamed.
		Spree::CreditCard.table_name = 'spree_credit_cards'

		creditcard = Spree::CreditCard.create(
			:cc_type => 'visa', 
			:month => 12, 
			:year => 2014, 
			:last_digits => '1111',
			:first_name => 'Sean', 
			:last_name => 'Schofield',
			:gateway_customer_profile_id => 'BGS-1234'
		)

		Spree::Order.all.each_with_index do |order, index|
			order.update!
			payment = order.payments.create!(:amount => order.total, :source => creditcard.clone, :payment_method => method)
			payment.update_columns(:state => 'pending', :response_code => '12345')
		end
		puts "done."
	end

	desc "Load all"
	task load: [ 
		:payment_methods, 
		:shipping_categories, 
		:shipping_methods, 
		:tax_categories, 
		:tax_rates, 
		:products, 
		:taxonomies, 
		:taxons,
		:option_types,
		:option_values,
		:product_option_types,
		:product_properties,
		:prototypes,
		:variants,
		:stock,
		:assets,
		:addresses,
		:orders,
		:adjustments,
		:payments
	]

end