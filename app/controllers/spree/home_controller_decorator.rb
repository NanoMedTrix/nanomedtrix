Spree::HomeController.class_eval do 
  def index
  	@headlines = Spree::Article.recent
  	@first_headline = @headlines.shift
  end
end
