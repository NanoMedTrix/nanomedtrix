module Spree
  module Admin
    module TablesHelper
      def row_state state 
        case state 
          when 'complete'
            'success'
          when 'cart'
            'warning'
          when 'canceled'
            'danger'
          else
            nil
        end
      end
    end
  end
end
