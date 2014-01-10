require 'acts-as-taggable-on'

class Spree::NewsArticle < ActiveRecord::Base
  before_save :create_permalink
  before_save :set_published_at

  validates :title, presence: true
  validates :body,  presence: true
  
  default_scope   -> { order( 'published_at DESC' ) }
  scope :visible, -> { where( visible: true ) }
  scope :recent,  lambda { | max = 5 | visible.limit( max ) }

  if Spree.user_class
    belongs_to :author, class_name: Spree.user_class.to_s
  else
    belongs_to :author
  end

  has_one :news_article_image, as: :viewable, dependent: :destroy, class_name: 'Spree::NewsArticleImage'

  accepts_nested_attributes_for :news_article_image, reject_if: :all_blank
  acts_as_taggable_on           :tags, 
                                :categories

  def article_summary( chars = 200 )
    if summary.blank?
      "#{ body[ 0...chars ] }..."
    else
      summary
    end
  end

  def self.by_date( date, period = nil )
    if date.is_a?( Hash )
      keys   = [ :day, :month, :year ].select { | key | date.include?( key ) }
      period = keys.first.to_s
      date   = DateTime.new( *keys.reverse.map { | key | date[ key ].to_i } )
    end

    time = date.to_time.in_time_zone
    where( published_at: ( time.send( "beginning_of_#{ period }" )..time.send( "end_of_#{ period }" ) ) )
  end 

  def self.by_tag( tag_name )
    tagged_with( tag_name, on: :tags )
  end

  def self.by_category( category_name )
    tagged_with( category_name, on: :categories )
  end

  def self.by_author( author )
    where( author_id: author )
  end

  # data for news archive widget, only visible entries
  def self.organize_news_articles
    Hash.new.tap do | articles |
      years.each do | year |
        months_for( year ).each do | month |
          date = DateTime.new( year, month )

          articles[ year ] ||= []
          articles[ year ] << [ date.strftime( "%B" ), self.visible.by_date( date, :month ) ]
        end
      end
    end
  end

  private

  def self.years
    visible.all.map { | e | e.published_at.year }.uniq
  end

  def self.months_for( year )
    visible.all.select { | e | e.published_at.year == year }.map { | e | e.published_at.month }.uniq
  end

  def create_permalink
    self.permalink = title.to_url if permalink.blank?
  end

  def set_published_at
    self.published_at = Time.now if published_at.blank?
  end

  def validate
    # nicEdit field contains "<br>" when blank
    errors.add( :body, "can't be blank" ) if body =~ /^<br>$/
  end
end 