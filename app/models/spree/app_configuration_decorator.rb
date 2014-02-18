Spree::AppConfiguration.class_eval do
	preference :banner_default_url,   :string, default: '/assets/banners/:id/:style/:basename.:extension'
	preference :banner_path,          :string, default: ':rails_root/public/assets/banners/:id/:style/:basename.:extension'
	preference :banner_url,           :string, default: '/assets/banners/:id/:style/:basename.:extension'
	preference :banner_styles,        :string, default: "{ \"mini\": \"48x48>\", \"small\": \"100x100>\", \"large\": \"800x200#\" }"
	preference :banner_default_style, :string, default: 'small'
	preference :banner_default_categories, :string, default: "{ \"logo\": \"Logo\", \"home_big\": \"Home Page Main\" }"
end
