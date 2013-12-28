namespace :bootstrap do 
	desc "Load payment methods"
	task payment_methods: :environment do 
		print "Loading payment methods... "

		Spree::Gateway::Bogus.create!({
			:name        => "Credit Card",
			:description => "Bogus payment gateway for development.",
			:environment => "development",
			:active      => true
		})

		Spree::Gateway::Bogus.create!({
			:name        => "Credit Card",
			:description => "Bogus payment gateway for production.",
			:environment => "production",
			:active      => true
		})

		Spree::Gateway::Bogus.create!({
			:name        => "Credit Card",
			:description => "Bogus payment gateway for staging.",
			:environment => "staging",
			:active      => true
		})

		Spree::Gateway::Bogus.create!({
			:name        => "Credit Card",
			:description => "Bogus payment gateway for test.",
			:environment => "test",
			:active      => true
		})

		Spree::PaymentMethod::Check.create!({
			:name        => "Check",
			:description => "Pay by check.",
			:active      => true
		})
		
		puts "done."
	end

	desc "Load shipping categories"
	task shipping_categories: :environment do 
		print "Loading shipping categories... "

		Spree::ShippingCategory.create!( :name => "Default" )

		puts "done."
	end

	desc "Load shipping methods"
	task shipping_methods: :environment do 
		print "Loading shipping methods... "

		begin
			north_america = Spree::Zone.find_by_name!( "North America" )
		rescue ActiveRecord::RecordNotFound
			puts "Couldn't find 'North America' zone. Did you run `rake db:seed` first?"
			puts "That task will set up the countries, states and zones required for Spree."
		
			exit
		end

		europe_vat        = Spree::Zone.find_by_name!( "EU_VAT" )
		shipping_category = Spree::ShippingCategory.find_or_create_by!( name: "Default" )

		shipping_methods = [
			{
				:name       => "UPS Ground (USD)",
				:zones      => [ north_america ],
				:calculator => Spree::Calculator::Shipping::FlatRate.create!,
				:shipping_categories => [ shipping_category ]
			},

			{
				:name       => "UPS Two Day (USD)",
				:zones      => [ north_america ],
				:calculator => Spree::Calculator::Shipping::FlatRate.create!,
				:shipping_categories => [ shipping_category ]
			},

			{
				:name       => "UPS One Day (USD)",
				:zones      => [ north_america ],
				:calculator => Spree::Calculator::Shipping::FlatRate.create!,
				:shipping_categories => [ shipping_category ]
			},

			{
				:name       => "UPS Ground (EUR)",
				:zones      => [ europe_vat ],
				:calculator => Spree::Calculator::Shipping::FlatRate.create!,
				:shipping_categories => [ shipping_category ]
			}
		]

		shipping_methods.each do | shipping_method_attrs |
			Spree::ShippingMethod.create!( shipping_method_attrs )
		end

		{
			"UPS Ground (USD)"  => [ 5,  "USD" ],
			"UPS Ground (EUR)"  => [ 5,  "EUR" ],
			"UPS One Day (USD)" => [ 15, "USD" ],
			"UPS Two Day (USD)" => [ 10, "USD" ]
		}.each do | shipping_method_name, ( price, currency ) |
			shipping_method = Spree::ShippingMethod.find_by_name!( shipping_method_name )

			shipping_method.calculator.preferred_amount   = price
			shipping_method.calculator.preferred_currency = currency
			shipping_method.shipping_categories           << Spree::ShippingCategory.first
		
			shipping_method.save!
		end

		puts "done."
	end

	desc "Load tax categories"
	task tax_categories: :environment do 
		print "Loading tax categories... "

			Spree::TaxCategory.create!( :name => "Bio" )

		puts "done."
	end

	desc "Load tax rates"
	task tax_rates: :environment do 
		print "Loading tax rates... "

		north_america = Spree::Zone.find_by_name!( "North America" )
		bio           = Spree::TaxCategory.find_by_name!( "Bio" )

		tax_rate = Spree::TaxRate.create(
			:name         => "Tax",
			:zone         => north_america,
			:amount       => 0.07,
			:tax_category => bio
		)
		tax_rate.calculator = Spree::Calculator::DefaultTax.create!
		tax_rate.save!

		puts "done."
	end

	desc "Load products"
	task products: :environment do 
		print "Loading products... "

		bio               = Spree::TaxCategory.find_by_name!( "Bio" )
		shipping_category = Spree::ShippingCategory.find_by_name!( "Default" )

		default_attrs = {
			:description  => Faker::Lorem.paragraph,
			:available_on => Time.zone.now
		}

		products = [
			{
				:name              => "NMT-RE -xxa",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 249.99,
				:eur_price         => 183
			},

			{
				:name              => "NMT-RE -xxb",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 599.99,
				:eur_price         => 437
			},

			{
				:name              => "NMT-RE -xxx",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 1499.99,
				:eur_price         => 1090
			},

			{
				:name              => "NMT-MSN -xxa",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 349.99,
				:eur_price         => 255
			},

			{
				:name              => "NMT-MSN -xxb",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 799.99,
				:eur_price         => 583
			},

			{
				:name              => "NMT-MSN -xxx",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 1999.99,
				:eur_price         => 1453
			},

			{
				:name              => "NMTx Stem Cells",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 499.99,
				:eur_price         => 364
			},

			{
				:name              => "NMTx Reagent 1",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 509.99,
				:eur_price         => 371
			},

			{
				:name              => "NMTx Reagent 2",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 299.99,
				:eur_price         => 219
			},

			{
				:name              => "NMTx Reagent 3",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 129.99,
				:eur_price         => 95
			},

			{
				:name              => "NMTx Petri Dishes - 50 Pack",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 24.99,
				:eur_price         => 19
			},

			{
				:name              => "NMTx 2 mL Vials - 100 Pack",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 64.99,
				:eur_price         => 47
			},

			{
				:name              => "NMTx 2 mL Vials - 500 Pack",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 279.99,
				:eur_price         => 204
			},

			{
				:name              => "NMTx 5 mL Vials - 100 Pack",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 91.99,
				:eur_price         => 67
			},

			{
				:name              => "NMTx 5 mL Vials - 500 Pack",
				:tax_category      => bio,
				:shipping_category => shipping_category,
				:price             => 409.99,
				:eur_price         => 299
			}
		]

		products.each do | product_attrs |
			eur_price = product_attrs.delete( :eur_price )

			Spree::Config[ :currency ] = "USD"
			default_shipping_category  = Spree::ShippingCategory.find_by_name!( "Default" )
			product                    = Spree::Product.create!( default_attrs.merge( product_attrs ) )

			Spree::Config[ :currency ] = "EUR"
			product.reload
			product.price              = eur_price
			product.shipping_category  = default_shipping_category

			product.save!
		end

		Spree::Config[ :currency ] = "USD"

		puts "done."
	end

	desc "Load taxonomies"
	task taxonomies: :environment do 
		print "Loading taxonomies... "

		taxonomies = [
			{ :name => "Categories" },
			{ :name => "Brand" }
		]

		taxonomies.each do | taxonomy_attrs |
			Spree::Taxonomy.create!( taxonomy_attrs )
		end

		puts "done."
	end

	desc "Load taxons"
	task taxons: :environment do 
		print "Loading taxons... "

		categories = Spree::Taxonomy.find_by_name!( "Categories" )
		brands     = Spree::Taxonomy.find_by_name!( "Brand" )

		products = { 
			:nmt_re_xxa             => "NMT-RE -xxa",
			:nmt_re_xxb             => "NMT-RE -xxb",
			:nmt_re_xxx             => "NMT-RE -xxx",
			:nmt_msn_xxa            => "NMT-MSN -xxa",
			:nmt_msn_xxb            => "NMT-MSN -xxb",
			:nmt_msn_xxx            => "NMT-MSN -xxx",
			:nmtx_stem_cells        => "NMTx Stem Cells",
			:nmtx_reagent_one       => "NMTx Reagent 1",
			:nmtx_reagent_two       => "NMTx Reagent 2",
			:nmtx_reagent_three     => "NMTx Reagent 3",
			:nmtx_petri_dishes      => "NMTx Petri Dishes - 50 Pack",
			:nmtx_small_vials_small => "NMTx 2 mL Vials - 100 Pack",
			:nmtx_small_vials_large => "NMTx 2 mL Vials - 500 Pack",
			:nmtx_large_vials_small => "NMTx 5 mL Vials - 100 Pack",
			:nmtx_large_vials_large => "NMTx 5 mL Vials - 500 Pack"
		}

		products.each do | key, name |
			products[ key ] = Spree::Product.find_by_name!( name )
		end

		taxons = [
			{
				:name     => "Categories",
				:taxonomy => categories,
				:position => 0
			},

			{
				:name     => "Nanoparticles",
				:taxonomy => categories,
				:parent   => "Categories",
				:position => 1,
				:products => [
					products[ :nmt_re_xxa ],
					products[ :nmt_re_xxb ],
					products[ :nmt_re_xxx ],
					products[ :nmt_msn_xxa ],
					products[ :nmt_msn_xxb ],
					products[ :nmt_msn_xxx ]
				]
			},

			{
				:name     => "Stem Cells",
				:taxonomy => categories,
				:parent   => "Categories",
				:position => 2,
				:products => [
					products[ :nmtx_stem_cells ]
				]
			},

			{
				:name     => "Reagents",
				:taxonomy => categories,
				:parent   => "Categories",
				:position => 3,
				:products => [
					products[ :nmtx_reagent_one ],
					products[ :nmtx_reagent_two ],
					products[ :nmtx_reagent_three ]
				]
			},

			{
				:name     => "Glassware",
				:taxonomy => categories,
				:parent   => "Categories",
				:position => 4
			},

			{
				:name     => "Petri Dishes",
				:taxonomy => categories,
				:parent   => "Glassware",
				:position => 0,
				:products => [
					products[ :nmtx_petri_dishes ]
				]
			},

			{
				:name     => "Vials",
				:taxonomy => categories,
				:parent   => "Glassware",
				:position => 1,
				:products => [
					products[ :nmtx_small_vials_small ],
					products[ :nmtx_small_vials_large ],
					products[ :nmtx_large_vials_small ],
					products[ :nmtx_large_vials_large ]
				]
			},

			{
				:name     => "Brands",
				:taxonomy => brands
			},

			{
				:name     => "NMT-RE",
				:taxonomy => brands,
				:parent   => "Brand",
				:position => 1,
				:products => [
					products[ :nmt_re_xxa ],
					products[ :nmt_re_xxb ],
					products[ :nmt_re_xxx ]
				]
			},

			{
				:name     => "NMT-MSN",
				:taxonomy => brands,
				:parent   => "Brand",
				:position => 2,
				:products => [
					products[ :nmt_msn_xxa ],
					products[ :nmt_msn_xxb ],
					products[ :nmt_msn_xxx ]
				]
			},

			{
				:name     => "NMTx",
				:taxonomy => brands,
				:parent   => "Brand",
				:position => 3,
				:products => [
					products[ :nmtx_stem_cells ],
					products[ :nmtx_reagent_one ],
					products[ :nmtx_reagent_two ],
					products[ :nmtx_reagent_three ],
					products[ :nmtx_petri_dishes ],
					products[ :nmtx_small_vials_small ],
					products[ :nmtx_small_vials_large ],
					products[ :nmtx_large_vials_small ],
					products[ :nmtx_large_vials_large ]
				]
			}
		]

		taxons.each do | taxon_attrs |
			if taxon_attrs[ :parent ]
				taxon_attrs[ :parent ] = Spree::Taxon.find_by_name!( taxon_attrs[ :parent ] )

				Spree::Taxon.create!( taxon_attrs )
			end
		end

		puts "done."
	end

	desc "Load option types"
	task option_types: :environment do 
		print "Loading option types... "

		Spree::OptionType.create!([
			{
				:name         => "species",
				:presentation => "Species",
				:position     => 1
			},

			{
				:name         => "stem-cell-type",
				:presentation => "Type",
				:position     => 1
			}
		])

		puts "done."
	end

	desc "Load option values"
	task option_values: :environment do 
		print "Loading option values... "

		species        = Spree::OptionType.find_by_presentation!( "Species" )
		stem_cell_type = Spree::OptionType.find_by_presentation!( "Type" )

		Spree::OptionValue.create!([
			{
				:name         => "Human",
				:presentation => "Human",
				:position     => 1,
				:option_type  => species
			},

			{
				:name         => "Mouse",
				:presentation => "Mouse",
				:position     => 2,
				:option_type  => species
			},

			{
				:name         => "Embryonic",
				:presentation => "Embryonic",
				:position     => 1,
				:option_type  => stem_cell_type
			},

			{
				:name         => "Somatic",
				:presentation => "Somatic",
				:position     => 2,
				:option_type  => stem_cell_type
			},

			{
				:name         => "Induced Pluripotent",
				:presentation => "iPSC",
				:position     => 3,
				:option_type  => stem_cell_type
			}
		])

		puts "done."
	end

	desc "Load product option types"
	task product_option_types: :environment do 
		print "Loading product option types... "

		species        = Spree::OptionType.find_by_presentation!( "Species" )
		stem_cell_type = Spree::OptionType.find_by_presentation!( "Type" )

		[ 
			"NMT-RE -xxa",
			"NMT-RE -xxb",
			"NMT-RE -xxx",
			"NMT-MSN -xxa",
			"NMT-MSN -xxb",
			"NMT-MSN -xxx"
		].each do | name |
			product              = Spree::Product.find_by_name!( name )
			product.option_types = [ species ]

			product.save!
		end

		nmtx_stem_cells              = Spree::Product.find_by_name!( "NMTx Stem Cells" )
		nmtx_stem_cells.option_types = [ species, stem_cell_type ]
		nmtx_stem_cells.save!

		puts "done."
	end

	desc "Load product properties"
	task product_properties: :environment do 
		print "Loading product properties... "

		products = { 
			"NMT-RE -xxa" => { 
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMT-RE",
				"Model"        => "NP0000"
			}, 

			"NMT-RE -xxb" => { 
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMT-RE",
				"Model"        => "NP0001"
			}, 

			"NMT-RE -xxx" => { 
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMT-RE",
				"Model"        => "NP0002"
			}, 

			"NMT-MSN -xxa" => { 
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMT-MSN",
				"Model"        => "NP1000"
			}, 

			"NMT-MSN -xxb" => { 
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMT-MSN",
				"Model"        => "NP1001"
			}, 

			"NMT-MSN -xxx" => { 
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMT-MSN",
				"Model"        => "NP1002"
			},

			"NMTx Stem Cells" => {
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMTx",
				"Model"        => "SC0000"
			},

			"NMTx Reagent 1" => {
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMTx",
				"Model"        => "RE0000"
			},

			"NMTx Reagent 2" => {
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMTx",
				"Model"        => "RE0001"
			},

			"NMTx Reagent 3" => {
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMTx",
				"Model"        => "RE0002"
			},

			"NMTx Petri Dishes - 50 Pack" => {
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMTx",
				"Model"        => "PD0000",
				"Size"         => "Outside: 100mm dia. x 15mm H, Inside: 88mm dia. x 12mm H (with lid on)",
				"Material"     => "Polystyrene",
				"Quantity"     => "50"
			},

			"NMTx 2 mL Vials - 100 Pack" => {
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMTx",
				"Model"        => "VL0000",
				"Size"         => "2 mL",
				"Quantity"     => "100"
			},

			"NMTx 2 mL Vials - 500 Pack" => {
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMTx",
				"Model"        => "VL0001",
				"Size"         => "2 mL",
				"Quantity"     => "500"
			},

			"NMTx 5 mL Vials - 100 Pack" => {
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMTx",
				"Model"        => "VL1000",
				"Size"         => "5 mL",
				"Quantity"     => "100"
			},

			"NMTx 5 mL Vials - 500 Pack" => {
				"Manufacturer" => "NanoMedTrix",
				"Brand"        => "NMTx",
				"Model"        => "VL1001",
				"Size"         => "5 mL",
				"Quantity"     => "500"
			}
		}

		products.each do | name, properties |
			product = Spree::Product.find_by_name( name )
			
			properties.each do | prop_name, prop_value |
				product.set_property( prop_name, prop_value )
			end
		end

		puts "done."
	end

	desc "Load prototypes"
	task prototypes: :environment do 
		print "Loading prototypes... "

		prototypes = [
			{
				:name       => "Nanoparticles",
				:properties => [ "Manufacturer", "Brand", "Model" ]
			},

			{
				:name       => "Stem Cells",
				:properties => [ "Manufacturer", "Brand", "Model" ]
			},

			{
				:name       => "Reagent",
				:properties => [ "Manufacturer", "Brand", "Model" ]
			},

			{
				:name       => "Petri Dish",
				:properties => [ "Manufacturer", "Brand", "Model", "Size", "Material", "Quantity" ]
			},

			{
				:name       => "Vial",
				:properties => [ "Manufacturer", "Brand", "Model", "Size", "Quantity" ]
			}
		]

		prototypes.each do | prototype_attrs |
			prototype = Spree::Prototype.create!( :name => prototype_attrs[ :name ] )
		
			prototype_attrs[ :properties ].each do | property |
				prototype.properties << Spree::Property.find_by_name!( property )
			end
		end

		puts "done."
	end

	desc "Load variants"
	task variants: :environment do 
		print "Loading variants... "

		nmt_re_xxa             = Spree::Product.find_by_name!( "NMT-RE -xxa" )
		nmt_re_xxb             = Spree::Product.find_by_name!( "NMT-RE -xxb" )
		nmt_re_xxx             = Spree::Product.find_by_name!( "NMT-RE -xxx" )
		nmt_msn_xxa            = Spree::Product.find_by_name!( "NMT-MSN -xxa" )
		nmt_msn_xxb            = Spree::Product.find_by_name!( "NMT-MSN -xxb" )
		nmt_msn_xxx            = Spree::Product.find_by_name!( "NMT-MSN -xxx" )
		nmtx_stem_cells        = Spree::Product.find_by_name!( "NMTx Stem Cells" )
		nmtx_reagent_one       = Spree::Product.find_by_name!( "NMTx Reagent 1" )
		nmtx_reagent_two       = Spree::Product.find_by_name!( "NMTx Reagent 2" )
		nmtx_reagent_three     = Spree::Product.find_by_name!( "NMTx Reagent 3" )
		nmtx_petri_dishes      = Spree::Product.find_by_name!( "NMTx Petri Dishes - 50 Pack" )
		nmtx_small_vials_small = Spree::Product.find_by_name!( "NMTx 2 mL Vials - 100 Pack" )
		nmtx_small_vials_large = Spree::Product.find_by_name!( "NMTx 2 mL Vials - 500 Pack" )
		nmtx_large_vials_small = Spree::Product.find_by_name!( "NMTx 5 mL Vials - 100 Pack" )
		nmtx_large_vials_large = Spree::Product.find_by_name!( "NMTx 5 mL Vials - 500 Pack" )

		human = Spree::OptionValue.find_by_name!( "Human" )
		mouse = Spree::OptionValue.find_by_name!( "Mouse" )

		embryonic = Spree::OptionValue.find_by_name!( "Embryonic" )
		somatic   = Spree::OptionValue.find_by_name!( "Somatic" )
		ipsc      = Spree::OptionValue.find_by_name!( "Induced Pluripotent" )

		variants = [
			{
				:product       => nmt_re_xxa,
				:option_values => [ human ],
				:sku           => "NMT-RE-00000",
				:cost_price    => 17
			},

			{
				:product       => nmt_re_xxa,
				:option_values => [ mouse ],
				:sku           => "NMT-RE-00001",
				:cost_price    => 17
			},

			{
				:product       => nmt_re_xxb,
				:option_values => [ human ],
				:sku           => "NMT-RE-00002",
				:cost_price    => 17
			},

			{
				:product       => nmt_re_xxb,
				:option_values => [ mouse ],
				:sku           => "NMT-RE-00003",
				:cost_price    => 17
			},

			{
				:product       => nmt_re_xxx,
				:option_values => [ human ],
				:sku           => "NMT-RE-00004",
				:cost_price    => 17
			},

			{
				:product       => nmt_re_xxx,
				:option_values => [ mouse ],
				:sku           => "NMT-RE-00005",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxa,
				:option_values => [ human ],
				:sku           => "NMT-MSN-00000",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxa,
				:option_values => [ mouse ],
				:sku           => "NMT-MSN-00001",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxb,
				:option_values => [ human ],
				:sku           => "NMT-MSN-00002",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxb,
				:option_values => [ mouse ],
				:sku           => "NMT-MSN-00003",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxx,
				:option_values => [ human ],
				:sku           => "NMT-MSN-00004",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxx,
				:option_values => [ mouse ],
				:sku           => "NMT-MSN-00005",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ human, embryonic ],
				:sku           => "NMTx-SC-00000",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ human, somatic ],
				:sku           => "NMTx-SC-00001",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ human, ipsc ],
				:sku           => "NMTx-SC-00002",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ mouse, embryonic ],
				:sku           => "NMTx-SC-00003",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ mouse, somatic ],
				:sku           => "NMTx-SC-00004",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ mouse, ipsc ],
				:sku           => "NMTx-SC-00005",
				:cost_price    => 17
			}
		]

		masters = {
			nmt_re_xxa => {
				:sku        => "NMT-RE-00006",
				:cost_price => 17
			},

			nmt_re_xxb => {
				:sku        => "NMT-RE-00007",
				:cost_price => 17
			},

			nmt_re_xxx => {
				:sku        => "NMT-RE-00008",
				:cost_price => 21
			},

			nmt_msn_xxa => {
				:sku        => "NMT-MSN-00006",
				:cost_price => 17
			},

			nmt_msn_xxb => {
				:sku        => "NMT-MSN-00007",
				:cost_price => 11
			},

			nmt_msn_xxx => {
				:sku        => "NMT-MSN-00008",
				:cost_price => 17
			},

			nmtx_stem_cells => {
				:sku        => "NMTx-SC-00007",
				:cost_price => 15
			},

			nmtx_reagent_one => {
				:sku        => "NMTx-REA-00000",
				:cost_price => 17
			},

			nmtx_reagent_two => {
				:sku        => "NMTx-REA-00001",
				:cost_price => 17
			},

			nmtx_reagent_three => {
				:sku        => "NMTx-REA-00002",
				:cost_price => 17
			},

			nmtx_petri_dishes => {
				:sku        => "NMTx-PD-00000",
				:cost_price => 15
			},

			nmtx_small_vials_small => {
				:sku        => "NMTx-SVL-00000",
				:cost_price => 17
			},

			nmtx_small_vials_large => {
				:sku        => "NMTx-SVL-00001",
				:cost_price => 11
			},

			nmtx_large_vials_small => {
				:sku        => "NMTx-LVL-00000",
				:cost_price => 17
			},

			nmtx_large_vials_large => {
				:sku        => "NMTx-LVL-00001",
				:cost_price => 13
			}
		}

		Spree::Variant.create!( variants )

		masters.each do | product, variant_attrs |
			product.master.update_attributes!( variant_attrs )
		end

		puts "done."
	end

	desc "Load stock"
	task stock: :environment do 
		print "Loading stock... "

		location         = Spree::StockLocation.first_or_create! name: "default"
		location.active  = true
		location.country = Spree::Country.where( iso: "US" ).first
		location.save!

		Spree::Variant.all.each do | variant |
			variant.stock_items.each do | stock_item |
				Spree::StockMovement.create( :quantity => 10, :stock_item => stock_item )
			end
		end

		puts "done."
	end

	desc "Load assets"
	task assets: :environment do 
		puts "Loading assets... "

		products = {}
		products[ :nmt_re_xxa ]             = Spree::Product.find_by_name!( "NMT-RE -xxa" ) 
		products[ :nmt_re_xxb ]             = Spree::Product.find_by_name!( "NMT-RE -xxb" )
		products[ :nmt_re_xxx ]             = Spree::Product.find_by_name!( "NMT-RE -xxx" )
		products[ :nmt_msn_xxa ]            = Spree::Product.find_by_name!( "NMT-MSN -xxa" )
		products[ :nmt_msn_xxb ]            = Spree::Product.find_by_name!( "NMT-MSN -xxb" )
		products[ :nmt_msn_xxx ]            = Spree::Product.find_by_name!( "NMT-MSN -xxx" )
		products[ :nmtx_stem_cells ]        = Spree::Product.find_by_name!( "NMTx Stem Cells" )
		products[ :nmtx_reagent_one ]       = Spree::Product.find_by_name!( "NMTx Reagent 1" )
		products[ :nmtx_reagent_two ]       = Spree::Product.find_by_name!( "NMTx Reagent 2" )
		products[ :nmtx_reagent_three ]     = Spree::Product.find_by_name!( "NMTx Reagent 3" )
		products[ :nmtx_petri_dishes ]      = Spree::Product.find_by_name!( "NMTx Petri Dishes - 50 Pack" )
		products[ :nmtx_small_vials_small ] = Spree::Product.find_by_name!( "NMTx 2 mL Vials - 100 Pack" )
		products[ :nmtx_small_vials_large ] = Spree::Product.find_by_name!( "NMTx 2 mL Vials - 500 Pack" )
		products[ :nmtx_large_vials_small ] = Spree::Product.find_by_name!( "NMTx 5 mL Vials - 100 Pack" )
		products[ :nmtx_large_vials_large ] = Spree::Product.find_by_name!( "NMTx 5 mL Vials - 500 Pack" )

		def image( name, type = "jpeg" )
			images_path = Pathname.new( File.dirname( __FILE__ ) ) + "images"
			path        = images_path + "#{ name }.#{ type }"

			return false if !File.exist?( path )
			File.open( path )
		end

		images = {
			products[ :nmt_re_xxa ].master => [
				{ :attachment => image( "nmt_re_xxa" ) }
			],

			products[ :nmt_re_xxb ].master => [
				{ :attachment => image( "nmt_re_xxb" ) }
			],

			products[ :nmt_re_xxx ].master => [
				{ :attachment => image( "nmt_re_xxx" ) }
			],

			products[ :nmt_msn_xxa ].master => [
				{ :attachment => image( "nmt_msn_xxa" ) }
			],

			products[ :nmt_msn_xxb ].master => [
				{ :attachment => image( "nmt_msn_xxb" ) }
			],

			products[ :nmt_msn_xxx ].master => [
				{ :attachment => image( "nmt_msn_xxx" ) }
			],

			products[ :nmtx_stem_cells ].master => [
				{ :attachment => image( "nmtx_stem_cells" ) }
			],

			products[ :nmtx_reagent_one ].master => [
				{ :attachment => image( "nmtx_reagent_one" ) }
			],

			products[ :nmtx_reagent_two ].master => [
				{ :attachment => image( "nmtx_reagent_two" ) }
			],

			products[ :nmtx_reagent_three ].master => [
				{ :attachment => image( "nmtx_reagent_three" ) }
			],

			products[ :nmtx_petri_dishes ].master => [
				{ :attachment => image( "nmtx_petri_dishes" ) }
			],

			products[ :nmtx_small_vials_small ].master => [
				{ :attachment => image( "nmtx_small_vials" ) }
			],

			products[ :nmtx_small_vials_large ].master => [
				{ :attachment => image( "nmtx_small_vials" ) }
			],

			products[ :nmtx_large_vials_small ].master => [
				{ :attachment => image( "nmtx_large_vials" ) }
			],

			products[ :nmtx_large_vials_large ].master => [
				{ :attachment => image( "nmtx_large_vials" ) }
			]
		}

		images.each do | variant, attachments |
			print "    loading images for #{ variant.name }... "

			attachments.each do | attachment |
				variant.images.create!( attachment )
			end

			puts "done."
		end

		puts " "
		puts "    assets loaded."
	end

	desc "Load addresses"
	task addresses: :environment do 
		print "Loading addresses... "

		united_states = Spree::Country.find_by_name!( "United States" )
		new_york      = Spree::State.find_by_name!( "New York" )

		# Billing address
		Spree::Address.create!(
			:firstname => Faker::Name.first_name,
			:lastname  => Faker::Name.last_name,
			:address1  => Faker::Address.street_address,
			:address2  => Faker::Address.secondary_address,
			:city      => Faker::Address.city,
			:state     => new_york,
			:zipcode   => 16804,
			:country   => united_states,
			:phone     => Faker::PhoneNumber.phone_number
		)

		#Shipping address
		Spree::Address.create!(
			:firstname => Faker::Name.first_name,
			:lastname  => Faker::Name.last_name,
			:address1  => Faker::Address.street_address,
			:address2  => Faker::Address.secondary_address,
			:city      => Faker::Address.city,
			:state     => new_york,
			:zipcode   => 16804,
			:country   => united_states,
			:phone     => Faker::PhoneNumber.phone_number
		)

		puts "done."
	end

	desc "Load orders"
	task orders: :environment do 
		print "Loading orders... "

		orders = []
		orders << Spree::Order.create!(
			:number           => "R123456789",
			:email            => "spree@example.com",
			:item_total       => 1809.97,
			:adjustment_total => 131.70,
			:total            => 1941.67,
			:shipping_address => Spree::Address.first,
			:billing_address  => Spree::Address.last
		)

		orders << Spree::Order.create!(
			:number           => "R987654321",
			:email            => "spree@example.com",
			:item_total       => 116.98,
			:adjustment_total => 13.19,
			:total            => 130.17,
			:shipping_address => Spree::Address.first,
			:billing_address  => Spree::Address.last
		)

		orders[ 0 ].line_items.create!(
			:variant  => Spree::Product.find_by_name!( "NMT-MSN -xxb" ).master,
			:quantity => 1,
			:price    => 799.99
		)

		orders[ 0 ].line_items.create!(
			:variant  => Spree::Product.find_by_name!( "NMTx Stem Cells" ).master,
			:quantity => 1,
			:price    => 499.99
		)

		orders[ 0 ].line_items.create!(
			:variant  => Spree::Product.find_by_name!( "NMTx Reagent 1" ).master,
			:quantity => 1,
			:price    => 509.99
		)

		orders[ 1 ].line_items.create!(
			:variant  => Spree::Product.find_by_name!( "NMTx Petri Dishes - 50 Pack" ).master,
			:quantity => 1,
			:price    => 24.99
		)

		orders[ 1 ].line_items.create!(
			:variant  => Spree::Product.find_by_name!( "NMTx 5 mL Vials - 100 Pack" ).master,
			:quantity => 1,
			:price    => 91.99
		)

		orders.each( &:create_proposed_shipments )

		orders.each do | order |
			order.state        = "complete"
			order.completed_at = Time.now - 1.day

			order.save!
		end

		puts "done."
	end

	desc "Load payments"
	task payments: :environment do 
		print "Loading payments... "

		# create payments based on the totals since they can't be known in YAML (quantities are random)
		method = Spree::PaymentMethod.where( :name => "Credit Card", :active => true ).first

		# Hack the current method so we're able to return a gateway without a RAILS_ENV
		Spree::Gateway.class_eval do
			def self.current
				Spree::Gateway::Bogus.new
			end
		end

		# This table was previously called spree_creditcards, and older migrations
		# reference it as such. Make it explicit here that this table has been renamed.
		Spree::CreditCard.table_name = "spree_credit_cards"

		creditcard = Spree::CreditCard.create(
			:cc_type     => "visa", 
			:month       => 12, 
			:year        => 2014, 
			:last_digits => "1111",
			:first_name  => "Sean", 
			:last_name   => "Schofield",
			:gateway_customer_profile_id => "BGS-1234"
		)

		Spree::Order.all.each_with_index do | order, index |
			order.update!

			payment = order.payments.create!( :amount => order.total, :source => creditcard.clone, :payment_method => method )
			payment.update_columns( :state => "pending", :response_code => "12345" )
		end

		puts "done."
	end

	desc "Completed text"
	task completed: :environment do 
		puts "Completed. Databases populated."
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
		:payments,
		:completed
	]
end
