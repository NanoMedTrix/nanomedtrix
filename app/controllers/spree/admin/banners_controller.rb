module Spree
  module Admin
    class BannersController < ResourceController
      def index
        respond_with @collection
      end

      def show
        redirect_to action: :edit
      end

      def update
        @banner.enhance_settings
        
        super
      end

      def clone
        @new = @banner.duplicate

        if @new.save
          flash.notice = Spree.t( 'notice_messages.banner_cloned' )
        else
          flash.notice = Spree.t( 'notice_messages.banner_not_cloned')
        end

        respond_with( @new ) { | format | format.html { redirect_to edit_admin_banner_url( @new ) } }
      end

      private
        def find_resource
          Spree::Banner.find( params[ :id ] )
        end

        def location_after_save
          edit_admin_banner_url( @banner )
        end

        def collection
          return @collection if @collection.present?

          params[ :q ]       ||= {}
          params[ :q ][ :s ] ||= 'category, position asc'

          @search     = super.ransack( params[ :q ] )
          @collection = @search.result.page( params[ :page ] ).per( Spree::Config[ :admin_products_per_page ] )
        end
    end
  end
end
