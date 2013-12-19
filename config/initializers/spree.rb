# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  config.site_name = "NanoMedTrix"
  config.site_url  = "pcruagxk-nanomedtrix.herokuapp.com"

  config.default_meta_keywords    = "nanomedtrix, nano, nanoparticles"
  config.default_meta_description = "NanoMedTrix development site"

  # S3 config for Heroku deployment
  if Rails.env.production?
		config.use_s3 = true

		config.attachment_url = ":s3_us_west_url"
		config.s3_host_alias  = "s3.amazonaws.com"

		config.s3_bucket     = ENV[ 'S3_BUCKET' ]
		config.s3_access_key = ENV[ 'S3_KEY' ]
		config.s3_secret     = ENV[ 'S3_SECRET' ]
	end
end

Spree.user_class = "Spree::User"

if Rails.env.production?
	Paperclip.interpolates( :s3_us_west_url ) do | attachment, style |
		"#{ attachment.s3_protocol }://#{ attachment.bucket_name }.#{ Spree::Config[ :s3_host_alias ] }/#{ attachment.path( style ).gsub( %r{^/}, "") }"
	end
end