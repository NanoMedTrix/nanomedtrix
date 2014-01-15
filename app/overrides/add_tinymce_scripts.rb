Deface::Override.new(
        virtual_path:  'spree/layouts/admin',
        name:          'add_tinymce_scripts',
        insert_bottom: "[data-hook='admin_footer_scripts']",
        text:          "<%= render partial: 'spree/admin/shared/tinymce', locals: { ids: [ 'product_description', 'page_body', 'news_article_body', 'news_article_summary' ] } %>",
        original:      'bf0956ff4a1899a1707b4e30c4c4089a17dac4f4'
)
