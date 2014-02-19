# undo spree auth devise admin navigation bar
Deface::Override.new(
	virtual_path: 'spree/admin/shared/_header',
	name:         'auth_admin_login_navigation_bar',
	disabled:     true
)
