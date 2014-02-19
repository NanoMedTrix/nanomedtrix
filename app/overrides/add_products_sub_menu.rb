Deface::Override.new(
	virtual_path: 'spree/admin/shared/_menu',
	name:         'admin_products_sub_menu',
	insert_bottom: '[data-hook="products_tab"]',
	partial:      'spree/admin/shared/_products_sub_menu'
)
