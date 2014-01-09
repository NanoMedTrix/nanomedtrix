Deface::Override.new(
	virtual_path: 'spree/admin/pages/index',
	name:         'content_sub_menu_index_page',
	text:         "<%= render partial: 'spree/admin/shared/content_sub_menu' %>",
	disabled:     false
)

Deface::Override.new(
	virtual_path: 'spree/admin/pages/edit',
	name:         'content_sub_menu_edit_page',
	text:         "<%= render partial: 'spree/admin/shared/content_sub_menu' %>",
	disabled:     false
)

Deface::Override.new(
	virtual_path: 'spree/admin/pages/new',
	name:         'content_sub_menu_new_page',
	text:         "<%= render partial: 'spree/admin/shared/content_sub_menu' %>",
	disabled:     false
)
