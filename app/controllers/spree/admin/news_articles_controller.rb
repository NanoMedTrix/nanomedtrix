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

    def spree_news_articles_params
      params.require( :spree_news_articles ).permit( Spree::PermittedAttributes.news_article_attributes.push :author_id, 
                                                                                                             :title, 
                                                                                                             :summary, 
                                                                                                             :body, 
                                                                                                             :permalink, 
                                                                                                             :visible, 
                                                                                                             :published_at, 
                                                                                                             :tag_list, 
                                                                                                             :category_list, 
                                                                                                             :news_article_image, 
                                                                                                             :news_article_image_attributes 
      )
    end
end
