Spree::Banner.create!(
	category:   'logo',
	attachment: File.open( Pathname.new( File.dirname( __FILE__ ) ) + 'banner' + 'nmtx-logo.png' ),
	enabled:    true
)

Spree::Banner.create!(
	category:   'home_big',
	attachment: File.open( Pathname.new( File.dirname( __FILE__ ) ) + 'banner' + 'nmtx-promo-001.png' ),
	enabled:    true
)
