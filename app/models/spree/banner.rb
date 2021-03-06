module Spree
  class Banner < ActiveRecord::Base
    validates            :category, presence: true
    validates_attachment :attachment,
                           presence: true,
                           content_type: {
                             content_type: [ 
                               'image/jpeg',
                               'image/jpg', 
                               'image/pjpeg',
                               'image/png',
                               'image/x-png', 
                               'image/gif'
                             ], 
                             message: Spree.t( :images_only )
                           }

    scope :enabled, lambda { | *categories |
      if categories.empty?
        where( enabled: true )
      else
        where( enabled: true ).where( category: categories )
      end
    }

    scope :with_category, ->( category ) { where( category: category ) }

    has_attached_file :attachment,
                        styles: lambda { | a | {
                          mini:           '48x48#',
                          home_carousel:  '800x450>',
                          featured_small: '270x240#',
                          featured_wide:  '560x130#',
                          featured_large: '560x390#',
                          custom: "#{ a.instance.attachment_width }x#{ a.instance.attachment_height }#"
                        } },
                        url:  '/assets/banners/:id/:style_:basename.:extension',
                        path: ':rails_root/public/assets/banners/:id/:style_:basename.:extension',
                        convert_options: { all: '-strip -auto-orient' }

    # save the w,h of the original image (from which others can be calculated)
    # we need to look at the write-queue for images which have not been saved yet
    after_post_process :find_dimensions

    Spree::Banner.attachment_definitions[ :attachment ][ :styles ]        = ActiveSupport::JSON.decode( Spree::Config[ :banner_styles ] ).symbolize_keys!
    Spree::Banner.attachment_definitions[ :attachment ][ :path ]          = Spree::Config[ :banner_path ]
    Spree::Banner.attachment_definitions[ :attachment ][ :url ]           = Spree::Config[ :banner_url ]
    Spree::Banner.attachment_definitions[ :attachment ][ :default_url ]   = Spree::Config[ :banner_default_url ]

    def initialize *args
      super *args

      category      = self.category
      last_banner   = Spree::Banner.with_category( category ).last
      self.position = last_banner ? last_banner.position + 1 : 0
    end

    # for adding banners which are closely related to existing ones
    # define "duplicate_extra" for site-specific actions, eg for additional fields
    def duplicate
      enhance_settings

      p            = self.dup
      p.category   = 'COPY OF ' + category
      p.created_at = p.updated_at = nil
      p.url        = url
      p.attachment = attachment

      # allow site to do some customization
      p.send( :duplicate_extra, self ) if p.respond_to?( :duplicate_extra )
      p.save!
      
      p
    end

    def find_dimensions
      temporary = attachment.queued_for_write[ :original ]
      filename  = temporary.path  unless temporary.nil?
      filename  = attachment.path if     filename.blank?
      geometry  = Paperclip::Geometry.from_file( filename )

      self.attachment_width  = geometry.width
      self.attachment_height = geometry.height
    end

    def enhance_settings
      extended_hash = {}

      ActiveSupport::JSON.decode( Spree::Config[ :banner_styles ] ).each do | key, value |
        extended_hash[ :"#{ key }" ] = value
      end

      Spree::Banner.attachment_definitions[ :attachment ][ :styles ]        = extended_hash
      Spree::Banner.attachment_definitions[ :attachment ][ :path ]          = Spree::Config[ :banner_path ]
      Spree::Banner.attachment_definitions[ :attachment ][ :url ]           = Spree::Config[ :banner_url ]
      Spree::Banner.attachment_definitions[ :attachment ][ :default_url ]   = Spree::Config[ :banner_default_url ]
    end

    def self.categories 
      ActiveSupport::JSON.decode( Spree::Config[ :banner_default_categories ] )
    end

    def self.categories_for_select
      unscoped.pluck( :category ).uniq.sort
    end
  end
end
