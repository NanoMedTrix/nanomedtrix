Spree::AppConfiguration.class_eval do
	preference :banner_default_url,        :string, default: '/assets/banners/:id/:style/:basename.:extension'
	preference :banner_path,               :string, default: ':rails_root/public/assets/banners/:id/:style/:basename.:extension'
	preference :banner_url,                :string, default: '/assets/banners/:id/:style/:basename.:extension'
	preference :banner_styles,             :string, default: "{ \"mini\": \"48x48#\", \"home_carousel\": \"800x450>\", \"featured_small\": \"270x240#\", \"featured_wide\": \"560x130#\", \"featured_large\": \"560x390#\" }"
	preference :banner_default_categories, :string, default: "{ \"logo\": \"Logo\", \"home_carousel\": \"Home Page Carousel\", \"products_featured\": \"Featured Products\" }"
end
