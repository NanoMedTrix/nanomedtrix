class Spree::Admin::ArticlesController < Spree::Admin::ResourceController
  helper 'spree/articles'

  private
    def location_after_save
      edit_admin_article_url( @article )
    end

    def collection
      page     = params[ :page ].to_i     > 0 ? params[ :page ].to_i     : 1
      per_page = params[ :per_page ].to_i > 0 ? params[ :per_page ].to_i : 20

      model_class.scoped.page( page ).per( per_page )
    end

    def spree_articles_params
      params.require( :spree_articles ).permit( Spree::PermittedAttributes.article_attributes.push :author_id, 
                                                                                                   :title, 
                                                                                                   :summary, 
                                                                                                   :body, 
                                                                                                   :permalink, 
                                                                                                   :visible, 
                                                                                                   :published_at, 
                                                                                                   :tag_list, 
                                                                                                   :category_list, 
                                                                                                   :article_image, 
                                                                                                   :article_image_attributes 
      )
    end
end
