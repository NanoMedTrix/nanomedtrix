nmt_re_xxa             = Spree::Product.find_by_name!( "NMT-RE -xxa" )
		nmt_re_xxb             = Spree::Product.find_by_name!( "NMT-RE -xxb" )
		nmt_re_xxx             = Spree::Product.find_by_name!( "NMT-RE -xxx" )
		nmt_msn_xxa            = Spree::Product.find_by_name!( "NMT-MSN -xxa" )
		nmt_msn_xxb            = Spree::Product.find_by_name!( "NMT-MSN -xxb" )
		nmt_msn_xxx            = Spree::Product.find_by_name!( "NMT-MSN -xxx" )
		nmtx_stem_cells        = Spree::Product.find_by_name!( "NMTx Stem Cells" )
		nmtx_reagent_one       = Spree::Product.find_by_name!( "NMTx Reagent 1" )
		nmtx_reagent_two       = Spree::Product.find_by_name!( "NMTx Reagent 2" )
		nmtx_reagent_three     = Spree::Product.find_by_name!( "NMTx Reagent 3" )
		nmtx_petri_dishes      = Spree::Product.find_by_name!( "NMTx Petri Dishes - 50 Pack" )
		nmtx_small_vials_small = Spree::Product.find_by_name!( "NMTx 2 mL Vials - 100 Pack" )
		nmtx_small_vials_large = Spree::Product.find_by_name!( "NMTx 2 mL Vials - 500 Pack" )
		nmtx_large_vials_small = Spree::Product.find_by_name!( "NMTx 5 mL Vials - 100 Pack" )
		nmtx_large_vials_large = Spree::Product.find_by_name!( "NMTx 5 mL Vials - 500 Pack" )

		human = Spree::OptionValue.find_by_name!( "Human" )
		mouse = Spree::OptionValue.find_by_name!( "Mouse" )

		embryonic = Spree::OptionValue.find_by_name!( "Embryonic" )
		somatic   = Spree::OptionValue.find_by_name!( "Somatic" )
		ipsc      = Spree::OptionValue.find_by_name!( "Induced Pluripotent" )

		variants = [
			{
				:product       => nmt_re_xxa,
				:option_values => [ human ],
				:sku           => "NMT-RE-00000",
				:cost_price    => 17
			},

			{
				:product       => nmt_re_xxa,
				:option_values => [ mouse ],
				:sku           => "NMT-RE-00001",
				:cost_price    => 17
			},

			{
				:product       => nmt_re_xxb,
				:option_values => [ human ],
				:sku           => "NMT-RE-00002",
				:cost_price    => 17
			},

			{
				:product       => nmt_re_xxb,
				:option_values => [ mouse ],
				:sku           => "NMT-RE-00003",
				:cost_price    => 17
			},

			{
				:product       => nmt_re_xxx,
				:option_values => [ human ],
				:sku           => "NMT-RE-00004",
				:cost_price    => 17
			},

			{
				:product       => nmt_re_xxx,
				:option_values => [ mouse ],
				:sku           => "NMT-RE-00005",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxa,
				:option_values => [ human ],
				:sku           => "NMT-MSN-00000",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxa,
				:option_values => [ mouse ],
				:sku           => "NMT-MSN-00001",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxb,
				:option_values => [ human ],
				:sku           => "NMT-MSN-00002",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxb,
				:option_values => [ mouse ],
				:sku           => "NMT-MSN-00003",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxx,
				:option_values => [ human ],
				:sku           => "NMT-MSN-00004",
				:cost_price    => 17
			},

			{
				:product       => nmt_msn_xxx,
				:option_values => [ mouse ],
				:sku           => "NMT-MSN-00005",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ human, embryonic ],
				:sku           => "NMTx-SC-00000",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ human, somatic ],
				:sku           => "NMTx-SC-00001",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ human, ipsc ],
				:sku           => "NMTx-SC-00002",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ mouse, embryonic ],
				:sku           => "NMTx-SC-00003",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ mouse, somatic ],
				:sku           => "NMTx-SC-00004",
				:cost_price    => 17
			},

			{
				:product       => nmtx_stem_cells,
				:option_values => [ mouse, ipsc ],
				:sku           => "NMTx-SC-00005",
				:cost_price    => 17
			}
		]

		masters = {
			nmt_re_xxa => {
				:sku        => "NMT-RE-00006",
				:cost_price => 17
			},

			nmt_re_xxb => {
				:sku        => "NMT-RE-00007",
				:cost_price => 17
			},

			nmt_re_xxx => {
				:sku        => "NMT-RE-00008",
				:cost_price => 21
			},

			nmt_msn_xxa => {
				:sku        => "NMT-MSN-00006",
				:cost_price => 17
			},

			nmt_msn_xxb => {
				:sku        => "NMT-MSN-00007",
				:cost_price => 11
			},

			nmt_msn_xxx => {
				:sku        => "NMT-MSN-00008",
				:cost_price => 17
			},

			nmtx_stem_cells => {
				:sku        => "NMTx-SC-00007",
				:cost_price => 15
			},

			nmtx_reagent_one => {
				:sku        => "NMTx-REA-00000",
				:cost_price => 17
			},

			nmtx_reagent_two => {
				:sku        => "NMTx-REA-00001",
				:cost_price => 17
			},

			nmtx_reagent_three => {
				:sku        => "NMTx-REA-00002",
				:cost_price => 17
			},

			nmtx_petri_dishes => {
				:sku        => "NMTx-PD-00000",
				:cost_price => 15
			},

			nmtx_small_vials_small => {
				:sku        => "NMTx-SVL-00000",
				:cost_price => 17
			},

			nmtx_small_vials_large => {
				:sku        => "NMTx-SVL-00001",
				:cost_price => 11
			},

			nmtx_large_vials_small => {
				:sku        => "NMTx-LVL-00000",
				:cost_price => 17
			},

			nmtx_large_vials_large => {
				:sku        => "NMTx-LVL-00001",
				:cost_price => 13
			}
		}

		Spree::Variant.create!( variants )

		masters.each do | product, variant_attrs |
			product.master.update_attributes!( variant_attrs )
		end