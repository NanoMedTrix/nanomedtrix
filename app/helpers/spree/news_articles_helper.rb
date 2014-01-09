module Spree
  module NewsArticlesHelper
    def post_link_list
      link = Struct.new( :name ,:url )
      
      NewsArticle.recent.collect { | post | link.new( post.title, news_article_permalink( post ) ) }
    end

    def news_article_permalink e 
      unless e.published_at.nil?
        news_article_permalink_path year: e.published_at.strftime( "%Y" ), month: e.published_at.strftime( "%m" ), day: e.published_at.strftime( "%d" ), slug: e.permalink
      else
        news_article_permalink_path year: 'na', month: 'na', day: 'na', slug: e.permalink
      end
    end

    def news_article_url_permalink e 
      unless e.published_at.nil?
        news_article_permalink_url year: e.published_at.strftime( "%Y" ), month: e.published_at.strftime( "%m" ), day: e.published_at.strftime( "%d" ), slug: e.permalink
      else
        news_article_permalink_url year: 'na', month: 'na', day: 'na', slug: e.permalink
      end
    end

    def news_full_article_html news_article 
      "<br><br>Read the full article #{ link_to news_article.title, news_article_url_permalink( news_article ) } at #{ link_to "#{ Spree::Config[ :site_name ] }", news_url }."
    end

    def news_first_appeared_html news_article 
      "<br><br>The article #{ link_to news_article.title, news_article_url_permalink( news_article ) } first appeared on #{ link_to "#{ Spree::Config[ :site_name ] }", news_url }."
    end

    def news_article_tag_list_html news_article
      news_article.tag_list.map { | tag | link_to tag, news_tag_path( tag ) }.join( ', ' ).html_safe
    end

    def news_article_category_list_html news_article
      news_article.category_list.map { | category | link_to category, news_category_path( category ) }.join( ', ' ).html_safe
    end
  end
end
