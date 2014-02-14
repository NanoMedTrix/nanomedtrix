Spree::Image.class_eval do
	has_attached_file :attachment,
											styles: { 
												mini:    '48x48>',
												small:   '64x64>',
												product: '240x240>',
												large:   '600x600>'
											},
											default_style: :product,
											url:           '/assets/product/images/:id/:style/:basename.:extension',
											path:          ':rails_root/public/assets/product/images/:id/:style/:basename.:extension',
											convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
end
