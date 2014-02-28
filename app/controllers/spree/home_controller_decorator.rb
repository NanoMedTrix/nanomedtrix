Spree::HomeController.class_eval do 
  def index
  	@carousel       = Spree::Banner.enabled( 'home_carousel' ).order( :position )
  	@headlines      = Spree::Article.recent
  	@first_headline = @headlines.shift
  end
end
