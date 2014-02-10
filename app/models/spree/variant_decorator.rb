Spree::Variant.class_eval do
  has_many :product_documents, as: :viewable, order: :position, dependent: :destroy
end
