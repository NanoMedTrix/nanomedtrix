module Spree
  module BannersHelper
    def insert_banner params = {}
      params[ :category ] ||= 'home'
      params[ :class ]    ||= 'banner'
      params[ :style ]    ||= Spree::Config[ :banner_default_style ]
      params[ :list ]     ||= false
      banners               = Spree::Banner.enabled( params[ :category ] ).order( :position )

      return '' if banners.empty?

      if params[ :list ]
        content_tag :ul do
          banners.map do | banner |
            content_tag :li, class: params[ :class ] do
              link_to_banner_or banner, params
            end
          end.join.html_safe
        end
      else
        banners.map do | banner |
          link_to_banner_or banner, params
        end.join.html_safe
      end
    end

    def link_to_banner_or banner, params
      src = banner.attachment.url( params[ :style ].to_sym )
      alt = banner.alt_text.presence || image_alt( src )

      if banner.url.blank?
        image_tag( src, alt: alt, class: 'img-responsive' )
      else
        link_to banner.url do 
          iamge_tag( src, alt: alt, class: 'img-responsive' )
        end
      end
    end
  end
end
