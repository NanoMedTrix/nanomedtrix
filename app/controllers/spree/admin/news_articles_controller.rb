class Spree::Admin::NewsArticlesController < Spree::Admin::ResourceController
  helper 'spree/news_articles'

  private
    def location_after_save
      edit_admin_news_article_url( @news_article )
    end

    def collection
      page     = params[ :page ].to_i     > 0 ? params[ :page ].to_i     : 1
      per_page = params[ :per_page ].to_i > 0 ? params[ :per_page ].to_i : 20

      model_class.scoped.page( page ).per( per_page )
    end
end
