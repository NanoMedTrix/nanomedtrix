Nanomedtrix::Application.routes.draw do
  mount Spree::Core::Engine, at: '/'

  Spree::Core::Engine.routes.draw do
		namespace :admin do
			resources :news_articles
		end

		resources :news_articles

		match '/news',                         to: 'news_articles#index',    as: :news
		match '/news/feed',                    to: 'news_articles#feed',     as: :news_feed, format: :rss
		match '/news/tag/:tag',                to: 'news_articles#tag',      as: :news_tag
		match '/news/author/:author',          to: 'news_articles#author',   as: :news_author
		match '/news/category/:category',      to: 'news_articles#category', as: :news_category
		match '/news/:year/:month/:day/:slug', to: 'news_articles#show',     as: :news_entry_permalink
		match '/news/:year(/:month)(/:day)',   to: 'news_articles#archive',  as: :news_archive, constraints: {
																																															year:  /(19|20)\d{2}/, 
																																															month: /[01]?\d/, 
																																															day:   /[0-3]?\d/
																																														}
	end
end
