module Spree
  module ArticlesHelper
    def post_link_list
      link = Struct.new( :name ,:url )
      
      Article.recent.collect { | post | link.new( post.title, article_permalink( post ) ) }
    end

    def article_permalink e 
      unless e.published_at.nil?
        article_permalink_path year: e.published_at.strftime( "%Y" ), month: e.published_at.strftime( "%m" ), day: e.published_at.strftime( "%d" ), slug: e.permalink
      else
        article_permalink_path year: 'na', month: 'na', day: 'na', slug: e.permalink
      end
    end

    def article_url_permalink e 
      unless e.published_at.nil?
        article_permalink_url year: e.published_at.strftime( "%Y" ), month: e.published_at.strftime( "%m" ), day: e.published_at.strftime( "%d" ), slug: e.permalink
      else
        article_permalink_url year: 'na', month: 'na', day: 'na', slug: e.permalink
      end
    end

    def full_article_html article 
      "<br><br>Read the full article #{ link_to article.title, article_url_permalink( article ) } at #{ link_to "#{ Spree::Config[ :site_name ] }", news_url }."
    end

    def article_first_appeared_html article 
      "<br><br>The article #{ link_to article.title, article_url_permalink( article ) } first appeared on #{ link_to "#{ Spree::Config[ :site_name ] }", news_url }."
    end

    def article_tag_list_html article
      article.tag_list.map { | tag | link_to tag, news_tag_path( tag ) }.join( ', ' ).html_safe
    end

    def article_category_list_html article
      article.category_list.map { | category | link_to category, news_category_path( category ) }.join( ', ' ).html_safe
    end
  end
end
