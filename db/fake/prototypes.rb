prototypes = [
	{
		name:       'Nanoparticles',
		properties: [ 'Manufacturer', 'Brand', 'Model' ]
	},

	{
		name:       'Stem Cells',
		properties: [ 'Manufacturer', 'Brand', 'Model' ]
	},

	{
		name:       'Reagent',
		properties: [ 'Manufacturer', 'Brand', 'Model' ]
	},

	{
		name:       'Petri Dish',
		properties: [ 'Manufacturer', 'Brand', 'Model', 'Size', 'Material', 'Quantity' ]
	},

	{
		name:       'Vial',
		properties: [ 'Manufacturer', 'Brand', 'Model', 'Size', 'Quantity' ]
	}
]

prototypes.each do | prototype_attrs |
	prototype = Spree::Prototype.create!( name: prototype_attrs[ :name ] )

	prototype_attrs[ :properties ].each do | property |
		prototype.properties << Spree::Property.find_by_name!( property )
	end
end
