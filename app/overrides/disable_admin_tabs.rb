# undo spree_auth_devise admin tab link
Deface::Override.new(
	virtual_path: 'spree/admin/shared/_menu',
	name: 'user_admin_tabs',
	disabled: true
)

# undo spree_static_content admin tab link
Deface::Override.new(
	virtual_path: 'spree/admin/shared/_menu',
	name: 'static_content_admin_tab',
	disabled: true
)
