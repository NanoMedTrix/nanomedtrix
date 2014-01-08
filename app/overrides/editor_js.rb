Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "include_rich_text_js",
                     :insert_bottom => "[data-hook='admin_footer_scripts']",
                     :text => "<%= render :partial => \"spree/admin/shared/editor_engines/#{"TinyMCE".underscore}\", :locals => { :ids => ['product_description', 'page_body']} %>")
