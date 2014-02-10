Spree::Image.class_eval do
	attachment_definitions[ :attachment ] = {
		url:  '/assets/product/images/:id/:style/:basename.:extension',
		path: ':rails_root/public/assets/product/images/:id/:style/:basename.:extension',
		styles: {
			mini:    '48x48>',
			small:   '64x64>',
			product: '240x240>',
			large:   '600x600>'
		}
	}
end
