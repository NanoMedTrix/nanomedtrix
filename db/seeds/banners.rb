Spree::Banner.create!(
	category:   'test',
	attachment: File.open( Pathname.new( File.dirname( __FILE__ ) ) + 'banner' + 'nmtx-promo-001.png' ),
	enabled:    true
)
