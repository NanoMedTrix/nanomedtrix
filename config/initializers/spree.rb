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
	config.use_s3 = true
	
	config.s3_bucket     = ENV[ 'S3_BUCKET' ]
	config.s3_access_key = ENV[ 'S3_KEY' ]
	config.s3_secret     = ENV[ 'S3_SECRET' ]
end

Spree.user_class = "Spree::User"
