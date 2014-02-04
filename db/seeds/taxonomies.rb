taxonomies = [
	{ name: 'Categories' },
	{ name: 'Services' },
	{ name: 'Guides & Tools' },
	{ name: 'Brand' }
]

taxonomies.each do | taxonomy_attrs |
	Spree::Taxonomy.create!( taxonomy_attrs )
end
