Spree::Product.class_eval do
	delegate :documents, to: :master, prefix: true

	has_many :variant_documents, source: :documents, through: :variants_including_master, order: :position
	alias_method :documents, :master_documents

  def self.find_by_array_of_ids ids
    products = Spree::Product.find( :all, conditions: [ "id IN (?)", ids ] )
    ids.map{ | id | products.detect{ | p | p.id == id.to_i } }.compact
  end
end
