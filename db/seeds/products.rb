bio               = Spree::TaxCategory.find_by_name!( 'Bio' )
shipping_category = Spree::ShippingCategory.find_by_name!( 'Default' )

default_attrs = {
	description:  Faker::Lorem.paragraph,
	available_on: Time.zone.now
}

products = [
	{
		name:              'NMTx NMT-RE -xxa',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             249.99,
		eur_price:         183
	},

	{
		name:              'NMTx NMT-RE -xxb',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             599.99,
		eur_price:         437
	},

	{
		name:              'NMTx NMT-RE -xxx',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             1499.99,
		eur_price:         1090
	},

	{
		name:              'NMTx NMT-MSN -xxa',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             349.99,
		eur_price:         255
	},

	{
		name:              'NMTx NMT-MSN -xxb',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             799.99,
		eur_price:         583
	},

	{
		name:              'NMTx NMT-MSN -xxx',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             1999.99,
		eur_price:         1453
	},

	{
		name:              'NMTx Stem Cells',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             499.99,
		eur_price:         364
	},

	{
		name:              'NMTx Reagent 1',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             509.99,
		eur_price:         371
	},

	{
		name:              'NMTx Reagent 2',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             299.99,
		eur_price:         219
	},

	{
		name:              'NMTx Reagent 3',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             129.99,
		eur_price:         95
	},

	{
		name:              'NMTx Petri Dishes - 50 Pack',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             24.99,
		eur_price:         19
	},

	{
		name:              'NMTx 2 mL Vials - 100 Pack',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             64.99,
		eur_price:         47
	},

	{
		name:              'NMTx 2 mL Vials - 500 Pack',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             279.99,
		eur_price:         204
	},

	{
		name:              'NMTx 5 mL Vials - 100 Pack',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             91.99,
		eur_price:         67
	},

	{
		name:              'NMTx 5 mL Vials - 500 Pack',
		tax_category:      bio,
		shipping_category: shipping_category,
		price:             409.99,
		eur_price:         299
	}
]

products.each do | product_attrs |
	eur_price = product_attrs.delete( :eur_price )

	Spree::Config[ :currency ] = 'USD'
	default_shipping_category  = Spree::ShippingCategory.find_by_name!( 'Default' )
	product                    = Spree::Product.create!( default_attrs.merge( product_attrs ) )

	Spree::Config[ :currency ] = 'EUR'
	product.reload
	product.price              = eur_price
	product.shipping_category  = default_shipping_category

	product.save!
end

Spree::Config[ :currency ] = 'USD'
