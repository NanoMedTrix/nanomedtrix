Nanomedtrix::Application.routes.draw do
  mount Spree::Core::Engine, at: '/'

  Spree::Core::Engine.routes.draw do
		namespace :admin do
			resources :articles
		end

		resources :articles

		match '/news',                       to: 'articles#index',    via: 'get', as: :news
		match '/news/feed',                  to: 'articles#feed',     via: 'get', as: :news_feed, format: :rss
		match '/news/tag/:tag',              to: 'articles#tag',      via: 'get', as: :news_tag
		match '/news/article/:slug',         to: 'articles#show',     via: 'get', as: :article_permalink
		match '/news/author/:author',        to: 'articles#author',   via: 'get', as: :news_author
		match '/news/category/:category',    to: 'articles#category', via: 'get', as: :news_category
		match '/news/:year(/:month)(/:day)', to: 'articles#archive',  via: 'get', as: :news_archive, constraints: {
																																																					year:  /(19|20)\d{2}/, 
																																																					month: /[01]?\d/, 
																																																					day:   /[0-3]?\d/
																																																				}
	end
end
