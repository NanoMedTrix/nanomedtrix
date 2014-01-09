class CreateNewsArticles < ActiveRecord::Migration
  def self.up
    create_table :spree_news_articles do | t |
    	t.column :author_id,    :integer
      t.column :title,        :string
      t.column :summary,      :text
      t.column :body,         :text
      t.column :permalink,    :string
      t.column :visible,      :boolean, default: true
      t.column :published_at, :datetime
      t.timestamps

      t.index :author_id
      Spree::Role.create!( name: 'publisher' ) unless Spree::Role.where( name: 'publisher' ).any?
    end
  end

  def self.down
    drop_table :spree_news_articles
    Spree::Role.where( name: 'publisher' ).destroy_all 
  end
end

