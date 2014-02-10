module Spree
  module ProductDocumentsHelper
    def get_document_icon document
      word_icon      = 'word_icon.png'
      excel_icon     = 'excel_icon.png'
      pdf_icon       = 'pdf_icon.png'
      file_extension = document.attachment.url.split( '.' )[ -1 ].downcase

      if file_extension.include?( 'pdf' )
        return pdf_icon
      elsif file_extension.include?( 'docx' ) || file_extension.include?( 'doc' )
        return word_icon
      else
        return excel_icon
      end
    end

    def get_document_name filename
      return  ( filename ) ? filename.gsub( /[_]/, ' ' ) : ''
    end
  end
end
