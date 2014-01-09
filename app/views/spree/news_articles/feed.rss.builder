xml.instruct! :xml, version: '1.0'

xml.rss version: '2.0' do
  xml.channel do
    xml.title       "#{ Spree::Config[ :site_name ] } News"
    xml.description ''
    xml.link        news_url

    @news_articles.each do | news_article |
      xml.item do
        xml.title       news_article.title
        xml.description news_article.article_summary + news_full_article_html( news_article )
        xml.content     news_article.body + news_first_appeared_html( news_article ), type: :html
        xml.pubDate     news_article.published_at.to_s( :rfc822 )
        xml.link        news_article_url_permalink( news_article )
        xml.guid        news_article_url_permalink( news_article )

        news_article.tag_list.each do | tag |
          xml.category tag
        end
      end
    end
  end
end
