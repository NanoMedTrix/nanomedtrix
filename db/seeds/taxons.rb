categories   = Spree::Taxonomy.find_by_name!( 'Categories' )
services     = Spree::Taxonomy.find_by_name!( 'Services' )
guides_tools = Spree::Taxonomy.find_by_name!( 'Guides & Tools' )
brands       = Spree::Taxonomy.find_by_name!( 'Brand' )

products = { 
	nmt_re_xxa:             'NMTx NMT-RE -xxa',
	nmt_re_xxb:             'NMTx NMT-RE -xxb',
	nmt_re_xxx:             'NMTx NMT-RE -xxx',
	nmt_msn_xxa:            'NMTx NMT-MSN -xxa',
	nmt_msn_xxb:            'NMTx NMT-MSN -xxb',
	nmt_msn_xxx:            'NMTx NMT-MSN -xxx',
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
		name:     'Services',
		taxonomy: services,
		position: 1
	},

	{
		name:     'Guides & Tools',
		taxonomy: guides_tools,
		position: 3
	},

	{
		name:     'Brands',
		taxonomy: brands
	}
]

categories_taxons = [
	{
		name: 'Antibodies & Immunoassays',
		taxonomy: categories,
		parent: 'Categories',
		position: 1,
		products: []
	},
	
	{
		name: 'Beads & Microspheres',
		taxonomy: categories,
		parent: 'Categories',
		position: 2,
		products: []
	},
	
	{
		name: 'Cell Culture & Transfection Reagents',
		taxonomy: categories,
		parent: 'Categories',
		position: 3,
		products: []
	},
	
	{
		name: 'Cellular Health Assays',
		taxonomy: categories,
		parent: 'Categories',
		position: 4,
		products: []
	},
	
	{
		name: 'Chromatography Columns & Resins',
		taxonomy: categories,
		parent: 'Categories',
		position: 5,
		products: []
	},
	
	{
		name: 'Data Analysis & Bioinformatics Software',
		taxonomy: categories,
		parent: 'Categories',
		position: 6,
		products: []
	},
	
	{
		name: 'DNA & RNA - Purification, Quantitation & Detection',
		taxonomy: categories,
		parent: 'Categories',
		position: 7,
		products: []
	},
	
	{
		name: 'Drug Discovery Assays',
		taxonomy: categories,
		parent: 'Categories',
		position: 8,
		products: []
	},
	
	{
		name: 'Gels & Membranes',
		taxonomy: categories,
		parent: 'Categories',
		position: 9,
		products: []
	},
	
	{
		name: 'Lab Instruments & Equipment',
		taxonomy: categories,
		parent: 'Categories',
		position: 10,
		products: []
	},
	
	{
		name: 'Lab Reagents & Chemicals',
		taxonomy: categories,
		parent: 'Categories',
		position: 11,
		products: []
	},
	
	{
		name: 'Labeling & Detection Products',
		taxonomy: categories,
		parent: 'Categories',
		position: 12,
		products: []
	},
	
	{
		name: 'Labware',
		taxonomy: categories,
		parent: 'Categories',
		position: 13,
		products: []
	},
	
	{
		name: 'Microarrays & PCR Arrays',
		taxonomy: categories,
		parent: 'Categories',
		position: 14,
		products: []
	},
	
	{
		name: 'PCR & Cloning Enzymes',
		taxonomy: categories,
		parent: 'Categories',
		position: 15,
		products: []
	},
	
	{
		name: 'Primers/Oligos, Cloning & Gene Synthesis',
		taxonomy: categories,
		parent: 'Categories',
		position: 16,
		products: []
	},
	
	{
		name: 'Proteins, Enzymes & Peptides',
		taxonomy: categories,
		parent: 'Categories',
		position: 17,
		products: []
	},
	
	{
		name: 'qPCR Assays, Master Mixes, Primer/Probe Sets & RNAi',
		taxonomy: categories,
		parent: 'Categories',
		position: 18,
		products: []
	},
	
	{
		name: 'Sequencing Kits & Reagents',
		taxonomy: categories,
		parent: 'Categories',
		position: 19,
		products: []
	},
	
	{
		name: 'Standards, Ladders & Controls',
		taxonomy: categories,
		parent: 'Categories',
		position: 20,
		products: []
	}
]

services_taxons = [
	{
		name:     'Molecular Biology Services',
		taxonomy: services,
		parent:   'Services',
		position: 1,
		products: [ ]
	},

	{
		name:     'Assay Development & Labeling Services',
		taxonomy: services,
		parent:   'Services',
		position: 2,
		products: [ ]
	},

	{
		name:     'Screening & Profiling',
		taxonomy: services,
		parent:   'Services',
		position: 3,
		products: [ ]
	},

	{
		name:     'Molecular Controls Builder',
		taxonomy: services,
		parent:   'Services',
		position: 4,
		products: [ ]
	},

	{
		name:     'Stem Cell Services',
		taxonomy: services,
		parent:   'Services',
		position: 5,
		products: [ ]
	},

	{
		name:     'Bioprocess Services',
		taxonomy: services,
		parent:   'Services',
		position: 6,
		products: [ ]
	},

	{
		name:     'cGMP Custom Manufacturing',
		taxonomy: services,
		parent:   'Services',
		position: 7,
		products: [ ]
	},

	{
		name:     'Non-cGMP Custom Manufacturing',
		taxonomy: services,
		parent:   'Services',
		position: 8,
		products: [ ]
	}
]

guides_tools_taxons = [
	{
		name:     'Cell Culture',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 1,
		products: [ ]
	},

	{
		name:     'Nucleic Acid Gel Electrophoresis',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 2,
		products: [ ]
	},

	{
		name:     'DNA Purification',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 3,
		products: [ ]
	},

	{
		name:     'RNA Extraction',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 4,
		products: [ ]
	},

	{
		name:     'Oligos, Primers & Probes',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 5,
		products: [ ]
	},

	{
		name:     'Cloning',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 6,
		products: [ ]
	},

	{
		name:     'PCR',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 7,
		products: [ ]
	},

	{
		name:     'Real-Time PCR',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 8,
		products: [ ]
	},

	{
		name:     'Sequencing',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 9,
		products: [ ]
	},

	{
		name:     'Protein Gel Electrophoresis',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 10,
		products: [ ]
	},

	{
		name:     'Western Blotting',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 11,
		products: [ ]
	},

	{
		name:     'Cell Analysis',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 12,
		products: [ ]
	},

	{
		name:     'Antibodies & Immunoassays',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 13,
		products: [ ]
	},

	{
		name:     'RNAi',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 14,
		products: [ ]
	},

	{
		name:     'Reverse Transcription',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 15,
		products: [ ]
	},

	{
		name:     'Stem Cell Research',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 16,
		products: [ ]
	},

	{
		name:     'Drug Discovery',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 17,
		products: [ ]
	},

	{
		name:     'Bioproduction',
		taxonomy: guides_tools,
		parent:   'Guides & Tools',
		position: 18,
		products: [ ]
	}
]

brand_taxons = [
	{
		name:     'NMTx',
		taxonomy: brands,
		parent:   'Brand',
		position: 1,
		products: [
			products[ :nmt_re_xxa ],
			products[ :nmt_re_xxb ],
			products[ :nmt_re_xxx ],
			products[ :nmt_msn_xxa ],
			products[ :nmt_msn_xxb ],
			products[ :nmt_msn_xxx ],
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
	},

	{
		name:     'Other Brand #2',
		taxonomy: brands,
		parent:   'Brand',
		position: 2,
		products: [
			
		]
	},

	{
		name:     'Other Brand #3',
		taxonomy: brands,
		parent:   'Brand',
		position: 3,
		products: [
			
		]
	},

	{
		name:     'Other Brand #4',
		taxonomy: brands,
		parent:   'Brand',
		position: 4,
		products: [
			
		]
	},

	{
		name:     'Other Brand #5',
		taxonomy: brands,
		parent:   'Brand',
		position: 5,
		products: [
			
		]
	},

	{
		name:     'Other Brand #6',
		taxonomy: brands,
		parent:   'Brand',
		position: 6,
		products: [
			
		]
	},

	{
		name:     'Other Brand #7',
		taxonomy: brands,
		parent:   'Brand',
		position: 7,
		products: [
			
		]
	},

	{
		name:     'Other Brand #8',
		taxonomy: brands,
		parent:   'Brand',
		position: 8,
		products: [
			
		]
	}
]

taxons = taxonomies + categories_taxons + services_taxons + guides_tools_taxons + brand_taxons

taxons.each do | taxon_attrs |
	if taxon_attrs[ :parent ]
		taxon_attrs[ :parent ] = Spree::Taxon.find_by_name!( taxon_attrs[ :parent ] )

		Spree::Taxon.create!( taxon_attrs )
	end
end
