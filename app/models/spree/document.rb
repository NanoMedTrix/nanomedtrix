module Spree
  class Document < Asset
    validate :no_attachment_errors

    has_attached_file :attachment,
                      url:  "/assets/product/documents/:id/:style/:basename.:extension",
                      path: ":rails_root/public/assets/product/documents/:id/:style/:basename.:extension"

    before_post_process :skip_thumbnail_creation

    ALLOWED_CONTENT_TYPES   = [ 'application/msword', 'application/vnd.ms-excel', 'application/pdf' ]
    ALLOWED_FILE_EXTENSIONS = [ 'pdf', 'doc', 'docx', 'xls', 'xlsx' ]

    include Spree::Core::S3Support
    supports_s3 :attachment

    Spree::Document.attachment_definitions[ :attachment ][ :styles ]        = ActiveSupport::JSON.decode( Spree::Config[ :attachment_styles ] ).symbolize_keys!
    Spree::Document.attachment_definitions[ :attachment ][ :path ]          = ":rails_root/public/assets/product/documents/:id/:style/:basename.:extension"
    Spree::Document.attachment_definitions[ :attachment ][ :url ]           = "/assets/product/documents/:id/:style/:basename.:extension"
    Spree::Document.attachment_definitions[ :attachment ][ :default_url ]   = Spree::Config[ :attachment_default_url ]
    Spree::Document.attachment_definitions[ :attachment ][ :default_style ] = Spree::Config[ :attachment_default_style ]

    def no_attachment_errors
      unless attachment.errors.empty?
        # uncomment this to get rid of the less-than-useful interrim messages
        # errors.clear 
        errors.add :attachment, "Paperclip returned errors for file '#{ attachment_file_name }' - check document source file."
        false
      end
    end

    private
      def skip_thumbnail_creation
        return false if ( attachment_content_type =~ /application\/.*pdf/ or ALLOWED_CONTENT_TYPES.include?( attachment_content_type ) )
      end
  end
end
