Deface::Override.new(
	virtual_path: 'spree/layouts/admin',
	name: 'add_tinymce_scripts_in_admin',
	insert_bottom: "[data-hook='admin_footer_scripts']",
	text: "<%= render partial: \"spree/admin/shared/tinymce\", locals: { ids: [ 'product_description', 'page_body', 'news_article_body' ] } %>"
)
