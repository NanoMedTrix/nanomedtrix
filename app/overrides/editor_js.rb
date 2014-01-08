Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "include_rich_text_js",
                     :insert_bottom => "[data-hook='admin_footer_scripts']",
                     :text => "<%= tinymce_assets %>")
