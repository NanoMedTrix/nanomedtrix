# Make the Doc Helper available to all views
Spree::Admin::ProductsController.class_eval do
    helper 'spree/admin/product_documents_helper.rb'
end