products                            = {}
products[ :nmt_re_xxa ]             = Spree::Product.find_by_name!( 'NMTx NMT-RE -xxa' ) 
products[ :nmt_re_xxb ]             = Spree::Product.find_by_name!( 'NMTx NMT-RE -xxb' )
products[ :nmt_re_xxx ]             = Spree::Product.find_by_name!( 'NMTx NMT-RE -xxx' )
products[ :nmt_msn_xxa ]            = Spree::Product.find_by_name!( 'NMTx NMT-MSN -xxa' )
products[ :nmt_msn_xxb ]            = Spree::Product.find_by_name!( 'NMTx NMT-MSN -xxb' )
products[ :nmt_msn_xxx ]            = Spree::Product.find_by_name!( 'NMTx NMT-MSN -xxx' )
products[ :nmtx_stem_cells ]        = Spree::Product.find_by_name!( 'NMTx Stem Cells' )
products[ :nmtx_reagent_one ]       = Spree::Product.find_by_name!( 'NMTx Reagent 1' )
products[ :nmtx_reagent_two ]       = Spree::Product.find_by_name!( 'NMTx Reagent 2' )
products[ :nmtx_reagent_three ]     = Spree::Product.find_by_name!( 'NMTx Reagent 3' )
products[ :nmtx_petri_dishes ]      = Spree::Product.find_by_name!( 'NMTx Petri Dishes - 50 Pack' )
products[ :nmtx_small_vials_small ] = Spree::Product.find_by_name!( 'NMTx 2 mL Vials - 100 Pack' )
products[ :nmtx_small_vials_large ] = Spree::Product.find_by_name!( 'NMTx 2 mL Vials - 500 Pack' )
products[ :nmtx_large_vials_small ] = Spree::Product.find_by_name!( 'NMTx 5 mL Vials - 100 Pack' )
products[ :nmtx_large_vials_large ] = Spree::Product.find_by_name!( 'NMTx 5 mL Vials - 500 Pack' )

def asset name, type, file_ext
	assets_path = Pathname.new( File.dirname( __FILE__ ) ) + "#{ type }"
	path        = assets_path + "#{ name }.#{ file_ext }"

	return false if !File.exist?( path )
	File.open( path )
end

def variant_assets product 
	product.variants.each do | variant |
		species  = variant.option_value( 'species' ).downcase
		document = asset( "nmtx-product-for-#{ species }-document", 'document', 'pdf' )

		variant.documents.create!( attachment: document )
	end
end    

assets = {
	products[ :nmt_re_xxa ].master => [
		{ attachment: asset( 'nmt_re_xxa', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmt_re_xxb ].master => [
		{ attachment: asset( 'nmt_re_xxb', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmt_re_xxx ].master => [
		{ attachment: asset( 'nmt_re_xxx', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmt_msn_xxa ].master => [
		{ attachment: asset( 'nmt_msn_xxa', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmt_msn_xxb ].master => [
		{ attachment: asset( 'nmt_msn_xxb', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmt_msn_xxx ].master => [
		{ attachment: asset( 'nmt_msn_xxx', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmtx_stem_cells ].master => [
		{ attachment: asset( 'nmtx_stem_cells', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmtx_reagent_one ].master => [
		{ attachment: asset( 'nmtx_reagent_one', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmtx_reagent_two ].master => [
		{ attachment: asset( 'nmtx_reagent_two', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmtx_reagent_three ].master => [
		{ attachment: asset( 'nmtx_reagent_three', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmtx_petri_dishes ].master => [
		{ attachment: asset( 'nmtx_petri_dishes', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmtx_small_vials_small ].master => [
		{ attachment: asset( 'nmtx_small_vials', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmtx_small_vials_large ].master => [
		{ attachment: asset( 'nmtx_small_vials', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmtx_large_vials_small ].master => [
		{ attachment: asset( 'nmtx_large_vials', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	],

	products[ :nmtx_large_vials_large ].master => [
		{ attachment: asset( 'nmtx_large_vials', 'image', 'jpeg' ) },
		{ attachment: asset( 'nmtx-product-document', 'document', 'pdf' ) }
	]
}

variant_assets( products[ :nmt_re_xxa ] )
variant_assets( products[ :nmt_re_xxb ] )
variant_assets( products[ :nmt_re_xxx ] )
variant_assets( products[ :nmt_msn_xxa ] )
variant_assets( products[ :nmt_msn_xxb ] )
variant_assets( products[ :nmt_msn_xxx ] )

products[ :nmtx_stem_cells ].variants.each do | variant |
	species  = variant.option_value( 'species' ).downcase
	document = asset( "nmtx-product-for-type-in-#{ species }-document", 'document', 'pdf' )

	variant.documents.create!( attachment: document )
end

assets.each do | variant, attachments |
	puts "-- loading image    #{ File.expand_path( attachments.first[ :attachment ], __FILE__ ) }"
	variant.images.create!( attachments.first )

	puts "-- loading document #{ File.expand_path( attachments.last[ :attachment ], __FILE__ ) }"
	variant.documents.create!( attachments.last )
end
