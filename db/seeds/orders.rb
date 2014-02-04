orders = []

orders << Spree::Order.create!(
	number:           'R123456789',
	email:            'spree@example.com',
	item_total:       1809.97,
	adjustment_total: 131.70,
	total:            1941.67,
	shipping_address: Spree::Address.first,
	billing_address:  Spree::Address.last
)

orders << Spree::Order.create!(
	number:           'R987654321',
	email:            'spree@example.com',
	item_total:       116.98,
	adjustment_total: 13.19,
	total:            130.17,
	shipping_address: Spree::Address.first,
	billing_address:  Spree::Address.last
)

orders[ 0 ].line_items.create!(
	variant:  Spree::Product.find_by_name!( 'NMTx NMT-MSN -xxb' ).master,
	quantity: 1,
	price:    799.99
)

orders[ 0 ].line_items.create!(
	variant:  Spree::Product.find_by_name!( 'NMTx Stem Cells' ).master,
	quantity: 1,
	price:    499.99
)

orders[ 0 ].line_items.create!(
	variant:  Spree::Product.find_by_name!( 'NMTx Reagent 1' ).master,
	quantity: 1,
	price:    509.99
)

orders[ 1 ].line_items.create!(
	variant:  Spree::Product.find_by_name!( 'NMTx Petri Dishes - 50 Pack' ).master,
	quantity: 1,
	price:    24.99
)

orders[ 1 ].line_items.create!(
	variant:  Spree::Product.find_by_name!( 'NMTx 5 mL Vials - 100 Pack' ).master,
	quantity: 1,
	price:    91.99
)

orders.each( &:create_proposed_shipments )
orders.each do | order |
	order.state        = 'complete'
	order.completed_at = Time.now - 1.day
	order.save!
end
