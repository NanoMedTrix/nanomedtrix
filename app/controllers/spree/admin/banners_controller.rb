module Spree
  module Admin
    class BannersController < ResourceController
      before_filter :load_categories
      create.before :update_position
      helper_method :clone_object_url
      
      def index
        session[ :return_to ] = request.url

        @collection
      end

      def show
        session[ :return_to ] ||= request.referer

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
          Banner.find( params[ :id ] )
        end

        def load_categories
          @categories = Spree::Banner.categories
        end

        def location_after_save
          edit_admin_banner_url( @banner )
        end

        def update_position
          c = params[ :banner ][ :category ]
          p = Spree::Banner.with_category( c ).last.position + 1

          params[ :banner ][ :position ] = p 
        end

        def collection
          @collection = {}

          params[ :q ]       ||= {}
          params[ :q ][ :s ] ||= 'position asc'
          
          Spree::Banner.categories.each do | key, value |
            params[ :q ][ :category_eq ] = key

            @search            = super.ransack( params[ :q ] )
            @collection[ key ] = @search.result
          end

          @collection
        end
        
        def clone_object_url resource
          clone_admin_banner_url resource
        end

        def spree_banners_params
          params.require( :spree_banners ).permit( Spree::PermittedAttributes.banner_attributes.push :caption,
                                                                                                     :alt_text, 
                                                                                                     :url,
                                                                                                     :category,
                                                                                                     :position,
                                                                                                     :enabled,
                                                                                                     :attachment
          )
        end
    end
  end
end
