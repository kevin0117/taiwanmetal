# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :manage, Customer, user_id: user.id
      can :manage, PriceBoard, user_id: user.id
      can :manage, ProductList, user_id: user.id
      can :manage, Product, user_id: user.id
      can :manage, Sale, user_id: user.id
      can :manage, Scrap, user_id: user.id
      can :manage, Vendor, user_id: user.id
      can :manage, RefineOrder, user_id: user.id
    end
  end
end
