products = { 
	'NMT-RE -xxa' => { 
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMT-RE',
		'Model'        => 'NP0000'
	}, 

	'NMT-RE -xxb' => { 
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMT-RE',
		'Model'        => 'NP0001'
	}, 

	'NMT-RE -xxx' => { 
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMT-RE',
		'Model'        => 'NP0002'
	}, 

	'NMT-MSN -xxa' => { 
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMT-MSN',
		'Model'        => 'NP1000'
	}, 

	'NMT-MSN -xxb' => { 
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMT-MSN',
		'Model'        => 'NP1001'
	}, 

	'NMT-MSN -xxx' => { 
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMT-MSN',
		'Model'        => 'NP1002'
	},

	'NMTx Stem Cells' => {
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMTx',
		'Model'        => 'SC0000'
	},

	'NMTx Reagent 1' => {
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMTx',
		'Model'        => 'RE0000'
	},

	'NMTx Reagent 2' => {
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMTx',
		'Model'        => 'RE0001'
	},

	'NMTx Reagent 3' => {
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMTx',
		'Model'        => 'RE0002'
	},

	'NMTx Petri Dishes - 50 Pack' => {
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMTx',
		'Model'        => 'PD0000',
		'Size'         => 'Outside: 100mm dia. x 15mm H, Inside: 88mm dia. x 12mm H (with lid on)',
		'Material'     => 'Polystyrene',
		'Quantity'     => '50'
	},

	'NMTx 2 mL Vials - 100 Pack' => {
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMTx',
		'Model'        => 'VL0000',
		'Size'         => '2 mL',
		'Quantity'     => '100'
	},

	'NMTx 2 mL Vials - 500 Pack' => {
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMTx',
		'Model'        => 'VL0001',
		'Size'         => '2 mL',
		'Quantity'     => '500'
	},

	'NMTx 5 mL Vials - 100 Pack' => {
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMTx',
		'Model'        => 'VL1000',
		'Size'         => '5 mL',
		'Quantity'     => '100'
	},

	'NMTx 5 mL Vials - 500 Pack' => {
		'Manufacturer' => 'NanoMedTrix',
		'Brand'        => 'NMTx',
		'Model'        => 'VL1001',
		'Size'         => '5 mL',
		'Quantity'     => '500'
	}
}

products.each do | name, properties |
	product = Spree::Product.find_by_name( name )

	properties.each do | prop_name, prop_value |
		product.set_property( prop_name, prop_value )
	end
end
