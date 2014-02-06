Spree::Tracker.create!(
	analytics_id: 'UA-47844228-1',
	environment:  Rails.env.production? ? 'production' : 'development',
	active:       true
)
