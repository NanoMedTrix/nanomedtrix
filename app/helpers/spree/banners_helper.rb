module Spree
  module BannersHelper
    def insert_banner_box params = {}
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
              link_to ( banner.url.blank? ? "javascript: void(0)" : banner.url ) do
                src = banner.attachment.url( params[ :style ].to_sym )
                
                image_tag( src, alt: banner.alt_text.presence || image_alt( src ) )
              end
            end
          end.join.html_safe
        end
      else
        banners.map do | banner |
          content_tag :div, class: params[ :class ] do
            link_to ( banner.url.blank? ? "javascript: void(0)" : banner.url ) do
              src = banner.attachment.url( params[ :style ].to_sym )

              image_tag( banner.attachment.url( params[ :style ].to_sym ), alt: banner.alt_text.presence || image_alt( src ) )
            end
          end
        end.join.html_safe
      end
    end
  end
end
