if Spree.user_class
  Spree.user_class.class_eval do
    has_many :news_articles, foreign_key: :author_id
  end
end
