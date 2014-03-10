class AddCaptionToBanners < ActiveRecord::Migration
  def self.up 
  	add_column :spree_banners, :caption, :string
  end

  def self.down
  	remove_column :spree_banners, :caption 
  end
end
