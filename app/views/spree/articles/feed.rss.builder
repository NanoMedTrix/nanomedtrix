xml.instruct! :xml, version: '1.0'

xml.rss version: '2.0' do
  xml.channel do
    xml.title       "#{ Spree::Config[ :site_name ] } News"
    xml.description ''
    xml.link        news_url

    @articles.each do | article |
      xml.item do
        xml.title       article.title
        xml.description article.article_summary + full_article_html( article )
        xml.content     article.body + article_first_appeared_html( article ), type: :html
        xml.pubDate     article.published_at.to_s( :rfc822 )
        xml.link        article_url_permalink( article )
        xml.guid        article_url_permalink( article )

        article.tag_list.each do | tag |
          xml.category tag
        end
      end
    end
  end
end
