Spree::Variant.class_eval do
  has_many :documents, as: :viewable, order: :position, dependent: :destroy
end
