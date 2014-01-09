class Spree::NewsArticlesController < Spree::StoreController
  helper 'spree/news_articles' 

  before_filter :init_pagination, only: [ :index, :tag, :archive, :author, :category ]
  rescue_from   ActiveRecord::RecordNotFound, with: :render_404
  
  def index
    @news_articles = Spree::NewsArticle.visible.page( @pagination_page ).per( @pagination_per_page )
  end
  
  def show
    if try_spree_current_user.try( :has_spree_role?, 'admin' )
      @news_article = Spree::NewsArticle.find_by_permalink!( params[ :slug ] )
    else
      @news_article = Spree::NewsArticle.visible.find_by_permalink!( params[ :slug ] )
    end

    @title = @news_article.title
  end

  def tag
    @news_articles = Spree::NewsArticle.visible.by_tag( params[ :tag ] ).page( @pagination_page ).per( @pagination_per_page )
    @tag_name      = params[ :tag ]
  end

  def category
    @news_articles = Spree::NewsArticle.visible.by_category( params[ :category ] ).page( @pagination_page ).per( @pagination_per_page )
    @category_name = params[:category]
  end

  def archive
    @news_articles = Spree::NewsArticle.visible.by_date( params ).page( @pagination_page ).per( @pagination_per_page )
  end
  
  def feed
    @news_articles = Spree::NewsArticle.visible.limit( 20 )
    render layout: false
  end

  def author
    @author        = Spree.user_class.where( email: params[ :author ] ).first
    @news_articles = Spree::NewsArticle.visible.by_author( @author ).page( @pagination_page ).per( @pagination_per_page )
  end

  private
    def init_pagination
      @pagination_page     = params[ :page ].to_i     > 0 ? params[ :page ].to_i     : 1
      @pagination_per_page = params[ :per_page ].to_i > 0 ? params[ :per_page ].to_i : 10
    end
end
