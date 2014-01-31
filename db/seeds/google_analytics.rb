Spree::Tracker.create!(
	analytics_id: 'UA-47455896-1',
	environment:  Rails.env.production? ? 'production' : 'development',
	active:       true
)
