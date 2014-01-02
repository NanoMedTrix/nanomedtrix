products                            = {}
products[ :nmt_re_xxa ]             = Spree::Product.find_by_name!( 'NMT-RE -xxa' ) 
products[ :nmt_re_xxb ]             = Spree::Product.find_by_name!( 'NMT-RE -xxb' )
products[ :nmt_re_xxx ]             = Spree::Product.find_by_name!( 'NMT-RE -xxx' )
products[ :nmt_msn_xxa ]            = Spree::Product.find_by_name!( 'NMT-MSN -xxa' )
products[ :nmt_msn_xxb ]            = Spree::Product.find_by_name!( 'NMT-MSN -xxb' )
products[ :nmt_msn_xxx ]            = Spree::Product.find_by_name!( 'NMT-MSN -xxx' )
products[ :nmtx_stem_cells ]        = Spree::Product.find_by_name!( 'NMTx Stem Cells' )
products[ :nmtx_reagent_one ]       = Spree::Product.find_by_name!( 'NMTx Reagent 1' )
products[ :nmtx_reagent_two ]       = Spree::Product.find_by_name!( 'NMTx Reagent 2' )
products[ :nmtx_reagent_three ]     = Spree::Product.find_by_name!( 'NMTx Reagent 3' )
products[ :nmtx_petri_dishes ]      = Spree::Product.find_by_name!( 'NMTx Petri Dishes - 50 Pack' )
products[ :nmtx_small_vials_small ] = Spree::Product.find_by_name!( 'NMTx 2 mL Vials - 100 Pack' )
products[ :nmtx_small_vials_large ] = Spree::Product.find_by_name!( 'NMTx 2 mL Vials - 500 Pack' )
products[ :nmtx_large_vials_small ] = Spree::Product.find_by_name!( 'NMTx 5 mL Vials - 100 Pack' )
products[ :nmtx_large_vials_large ] = Spree::Product.find_by_name!( 'NMTx 5 mL Vials - 500 Pack' )

def image( name, type = 'jpeg' )
	images_path = Pathname.new( File.dirname( __FILE__ ) ) + 'images'
	path        = images_path + "#{ name }.#{ type }"

	return false if !File.exist?( path )
	File.open( path )
end

images = {
	products[ :nmt_re_xxa ].master => [
		{ attachment: image( 'nmt_re_xxa' ) }
	],

	products[ :nmt_re_xxb ].master => [
		{ attachment: image( 'nmt_re_xxb' ) }
	],

	products[ :nmt_re_xxx ].master => [
		{ attachment: image( 'nmt_re_xxx' ) }
	],

	products[ :nmt_msn_xxa ].master => [
		{ attachment: image( 'nmt_msn_xxa' ) }
	],

	products[ :nmt_msn_xxb ].master => [
		{ attachment: image( 'nmt_msn_xxb' ) }
	],

	products[ :nmt_msn_xxx ].master => [
		{ attachment: image( 'nmt_msn_xxx' ) }
	],

	products[ :nmtx_stem_cells ].master => [
		{ attachment: image( 'nmtx_stem_cells' ) }
	],

	products[ :nmtx_reagent_one ].master => [
		{ attachment: image( 'nmtx_reagent_one' ) }
	],

	products[ :nmtx_reagent_two ].master => [
		{ attachment: image( 'nmtx_reagent_two' ) }
	],

	products[ :nmtx_reagent_three ].master => [
		{ attachment: image( 'nmtx_reagent_three' ) }
	],

	products[ :nmtx_petri_dishes ].master => [
		{ attachment: image( 'nmtx_petri_dishes' ) }
	],

	products[ :nmtx_small_vials_small ].master => [
		{ attachment: image( 'nmtx_small_vials' ) }
	],

	products[ :nmtx_small_vials_large ].master => [
		{ attachment: image( 'nmtx_small_vials' ) }
	],

	products[ :nmtx_large_vials_small ].master => [
		{ attachment: image( 'nmtx_large_vials' ) }
	],

	products[ :nmtx_large_vials_large ].master => [
		{ attachment: image( 'nmtx_large_vials' ) }
	]
}

images.each do | variant, attachments |
	attachments.each do | attachment |
		puts "-- loading image #{ File.expand_path( attachment[ :attachment ], __FILE__ ) }"
		variant.images.create!( attachment )
	end
end
