Spree::ProductsController.class_eval do
  helper 'spree/product_documents'
  
	after_filter :recently_viewed, only: :show

  def index
    @searcher = build_searcher( params )
    @products = @searcher.retrieve_products

    @featured_banners = Spree::Banner.enabled( 'products_featured' ).order( :position )
    @featured_large   = @featured_banners.shift
    @featured_small   = @featured_banners.shift
    @featured_wide    = @featured_banners.shift

    @catalog      = Spree::Taxonomy.includes( root: :children ).find_by_name!( 'Categories' ).root
    @services     = Spree::Taxonomy.includes( root: :children ).find_by_name!( 'Services' ).root
    @guides_tools = Spree::Taxonomy.includes( root: :children ).find_by_name!( 'Guides & Tools' ).root
    @brands       = Spree::Taxonomy.includes( root: :children ).find_by_name!( 'Brand' ).root

    @top         = Spree::Product.limit( 10 )
    @recommended = Spree::Product.limit( 15 )
  end

  def recently_viewed
    id            = @product.id
    rvp           = ( session[ 'recently_viewed_products' ] || '' ).split( ', ' )
    rvp_max_count = 5

    rvp.delete( id )
    rvp << id unless rvp.include?( id.to_s )
    rvp.delete_at( 0 ) if rvp.size > rvp_max_count.to_i

    session[ 'recently_viewed_products' ] = rvp.join( ', ' )
  end
end
