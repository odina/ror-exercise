class Ability
  include CanCan::Ability

  def initialize(user)
    can :access, :rails_admin
    can :dashboard

    if user && user.is_admin?
      can :manage, :all
    else
      can :read, :all
    end
  end
end
