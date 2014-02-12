Deface::Override.new(
	virtual_path:  "spree/layouts/admin",
	name:          "banner_admin_tab",
	insert_bottom: "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
	text:          "<%= tab( :banner, icon: 'icon-bookmark') %>"
)

Deface::Override.new(
	virtual_path:  "spree/admin/shared/_configuration_menu",
	name:          "add_banner_settings",
	insert_bottom: "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
	text:          "<%= configurations_sidebar_menu_item( Spree.t( :banner_settings ), edit_admin_banner_settings_url ) %>"
)
