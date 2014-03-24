Spree::Banner.create!(
	category:   'logo',
	attachment: File.open( Pathname.new( File.dirname( __FILE__ ) ) + 'banner' + 'nmtx-logo.png' ),
	enabled:    true,
	position:   0
)

Spree::Banner.create!(
	category:   'home_carousel',
	position:   0,
	attachment: File.open( Pathname.new( File.dirname( __FILE__ ) ) + 'banner' + 'nmtx-promo-001.png' ),
	caption:    "Step into tomorrow's research in target reagents",
	enabled:    true
)

Spree::Banner.create!(
	category:   'home_carousel',
	position:   1,
	attachment: File.open( Pathname.new( File.dirname( __FILE__ ) ) + 'banner' + 'nmtx-promo-002.jpg' ),
	caption:    "Dare to explore the new frontiers in contrast agents",
	enabled:    true
)

Spree::Banner.create!(
	category:   'home_carousel',
	position:   2,
	attachment: File.open( Pathname.new( File.dirname( __FILE__ ) ) + 'banner' + 'nmtx-promo-003.jpg' ),
	caption:    "Let us help you in a cost-effective tracking technology",
	enabled:    true
)

Spree::Banner.create!(
	category:   'home_carousel',
	position:   3,
	attachment: File.open( Pathname.new( File.dirname( __FILE__ ) ) + 'banner' + 'nmtx-promo-004.jpg' ),
	caption:    "Small particles for a large contrast",
	enabled:    true
)

Spree::Banner.create!(
	category:   'products_featured',
	position:   0,
	attachment: File.open( Pathname.new( File.dirname( __FILE__ ) ) + 'banner' + 'nmtx-featured-001.jpg' ),
	enabled:    true
)

Spree::Banner.create!(
	category:   'products_featured',
	position:   1,
	attachment: File.open( Pathname.new( File.dirname( __FILE__ ) ) + 'banner' + 'nmtx-featured-002.jpg' ),
	enabled:    true
)

Spree::Banner.create!(
	category:   'products_featured',
	position:   2,
	attachment: File.open( Pathname.new( File.dirname( __FILE__ ) ) + 'banner' + 'nmtx-featured-003.jpg' ),
	enabled:    true
)
