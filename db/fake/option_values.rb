species        = Spree::OptionType.find_by_presentation!( 'Species' )
stem_cell_type = Spree::OptionType.find_by_presentation!( 'Type' )

Spree::OptionValue.create!([
	{
		name:         'Human',
		presentation: 'Human',
		position:     1,
		option_type:  species
	},

	{
		name:         'Mouse',
		presentation: 'Mouse',
		position:     2,
		option_type:  species
	},

	{
		name:         'Embryonic',
		presentation: 'Embryonic',
		position:     1,
		option_type:  stem_cell_type
	},

	{
		name:         'Somatic',
		presentation: 'Somatic',
		position:     2,
		option_type:  stem_cell_type
	},

	{
		name:         'Induced Pluripotent',
		presentation: 'iPSC',
		position:     3,
		option_type:  stem_cell_type
	}
])
