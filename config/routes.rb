Nanomedtrix::Application.routes.draw do
  mount Spree::Core::Engine, at: '/'

  Spree::Core::Engine.routes.draw do
		namespace :admin do
			resources :news_articles
		end

		resources :news_articles

		match '/news',                       to: 'news_articles#index',    via: 'get', as: :news
		match '/news/feed',                  to: 'news_articles#feed',     via: 'get', as: :news_feed, format: :rss
		match '/news/tag/:tag',              to: 'news_articles#tag',      via: 'get', as: :news_tag
		match '/news/article/:slug',         to: 'news_articles#show',     via: 'get', as: :news_article_permalink
		match '/news/author/:author',        to: 'news_articles#author',   via: 'get', as: :news_author
		match '/news/category/:category',    to: 'news_articles#category', via: 'get', as: :news_category
		match '/news/:year(/:month)(/:day)', to: 'news_articles#archive',  via: 'get', as: :news_archive, constraints: {
																																																					year:  /(19|20)\d{2}/, 
																																																					month: /[01]?\d/, 
																																																					day:   /[0-3]?\d/
																																																				}
	end
end
