categories = Spree::Taxonomy.find_by_name!( 'Categories' )
brands     = Spree::Taxonomy.find_by_name!( 'Brand' )

products = { 
	nmt_re_xxa:             'NMT-RE -xxa',
	nmt_re_xxb:             'NMT-RE -xxb',
	nmt_re_xxx:             'NMT-RE -xxx',
	nmt_msn_xxa:            'NMT-MSN -xxa',
	nmt_msn_xxb:            'NMT-MSN -xxb',
	nmt_msn_xxx:            'NMT-MSN -xxx',
	nmtx_stem_cells:        'NMTx Stem Cells',
	nmtx_reagent_one:       'NMTx Reagent 1',
	nmtx_reagent_two:       'NMTx Reagent 2',
	nmtx_reagent_three:     'NMTx Reagent 3',
	nmtx_petri_dishes:      'NMTx Petri Dishes - 50 Pack',
	nmtx_small_vials_small: 'NMTx 2 mL Vials - 100 Pack',
	nmtx_small_vials_large: 'NMTx 2 mL Vials - 500 Pack',
	nmtx_large_vials_small: 'NMTx 5 mL Vials - 100 Pack',
	nmtx_large_vials_large: 'NMTx 5 mL Vials - 500 Pack'
}

products.each do | key, name |
	products[ key ] = Spree::Product.find_by_name!( name )
end

taxonomies = [
	{ 
		name:     'Categories',
		taxonomy: categories,
		position: 0
	},

	{
		name:     'Brands',
		taxonomy: brands
	}
]

categories_taxons = [
	{
		name:     'Nanoparticles',
		taxonomy: categories,
		parent:   'Categories',
		position: 1,
		products: [
			products[ :nmt_re_xxa ],
			products[ :nmt_re_xxb ],
			products[ :nmt_re_xxx ],
			products[ :nmt_msn_xxa ],
			products[ :nmt_msn_xxb ],
			products[ :nmt_msn_xxx ]
		]
	},

	{
		name:     'Stem Cells',
		taxonomy: categories,
		parent:   'Categories',
		position: 2,
		products: [
			products[ :nmtx_stem_cells ]
		]
	},

	{
		name:     'Reagents',
		taxonomy: categories,
		parent:   'Categories',
		position: 3,
		products: [
			products[ :nmtx_reagent_one ],
			products[ :nmtx_reagent_two ],
			products[ :nmtx_reagent_three ]
		]
	},

	{
		name:     'Glassware',
		taxonomy: categories,
		parent:   'Categories',
		position: 4
	},

		{
			name:     'Petri Dishes',
			taxonomy: categories,
			parent:   'Glassware',
			position: 0,
			products: [
				products[ :nmtx_petri_dishes ]
			]
		},

		{
			name:     'Vials',
			taxonomy: categories,
			parent:   'Glassware',
			position: 1,
			products: [
				products[ :nmtx_small_vials_small ],
				products[ :nmtx_small_vials_large ],
				products[ :nmtx_large_vials_small ],
				products[ :nmtx_large_vials_large ]
			]
		}
]

brand_taxons = [
	{
		name:     'NMT-RE',
		taxonomy: brands,
		parent:   'Brand',
		position: 1,
		products: [
			products[ :nmt_re_xxa ],
			products[ :nmt_re_xxb ],
			products[ :nmt_re_xxx ]
		]
	},

	{
		name:     'NMT-MSN',
		taxonomy: brands,
		parent:   'Brand',
		position: 2,
		products: [
			products[ :nmt_msn_xxa ],
			products[ :nmt_msn_xxb ],
			products[ :nmt_msn_xxx ]
		]
	},

	{
		name:     'NMTx',
		taxonomy: brands,
		parent:   'Brand',
		position: 3,
		products: [
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

taxons = taxonomies + categories_taxons + brand_taxons

taxons.each do | taxon_attrs |
	if taxon_attrs[ :parent ]
		taxon_attrs[ :parent ] = Spree::Taxon.find_by_name!( taxon_attrs[ :parent ] )

		Spree::Taxon.create!( taxon_attrs )
	end
end
