north_america = Spree::Zone.find_by_name!( 'North America' )
bio           = Spree::TaxCategory.find_by_name!( 'Bio' )

tax_rate = Spree::TaxRate.create(
	name:         'Tax',
	zone:         north_america,
	amount:       0.07,
	tax_category: bio
)

tax_rate.calculator = Spree::Calculator::DefaultTax.create!
tax_rate.save!
