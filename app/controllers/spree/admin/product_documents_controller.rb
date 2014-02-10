module Spree
  module Admin
    class ProductDocumentsController < ResourceController
      before_filter :load_data

      create.before :set_viewable
      update.before :set_viewable
      destroy.before :destroy_before

      private
        def location_after_save
          admin_product_documents_url( @product )
        end

        def load_data
          @product  = Spree::Product.where( permalin: params[ :product_id] ).first
          @variants = @product.variants.collect do | variant |
            [ variant.options_text, variant.id ]
          end

          @variants.insert( 0, [ I18n.t( :all ), @product.master.id ] )
        end

        def set_viewable
          @doc.viewable_type = 'Spree::Variant'
          @doc.viewable_id   = params[ :doc ][ :viewable_id ]
        end

        def destroy_before
          @viewable = @doc.viewable
        end
    end
  end
end
