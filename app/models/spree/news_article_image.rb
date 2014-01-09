class Spree::NewsArticleImage < Spree::Image
  has_attached_file :attachment, 
    									styles: { 
    										mini:   '48x48#', 
    										normal: '200x200>', 
    										large:  '600x600>'
    									},
     									default_style: :large,
     									url:  "/assets/news_article_images/:id/:style/:basename.:extension",
     									path: ":rails_root/public/assets/news_article_images/:id/:style/:basename.:extension"  
end
