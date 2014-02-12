class CreateBanners < ActiveRecord::Migration
  def self.up
    create_table :spree_banners do | t |
    	t.column :alt_text, :string
    	t.column :url,      :string
    	t.column :category, :string
    	t.column :position, :integer
    	t.column :enabled,  :boolean, default: false

    	t.column :attachment_file_name,    :string
    	t.column :attachment_content_type, :string
    	t.column :attachment_width,        :integer
    	t.column :attachment_height,       :integer
    	t.column :attachment_size,         :integer
    	t.column :attachment_updated_at,   :datetime

    	t.timestamps
    end
  end

  def self.down
    drop_table :spree_banners
  end
end

