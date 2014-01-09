class SpreeNewsSpreeAbility
  include CanCan::Ability

  def initialize( user )
    can :read,  Spree::NewsArticle
    can :index, Spree::NewsArticle
  end
end
