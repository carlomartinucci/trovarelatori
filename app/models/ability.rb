class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.editor?
      can :manage, :all
      cannot :manage, User
      # cannot :create, Theme
      cannot :update, Theme
      cannot :destroy, Theme
      cannot :see_owner, Claim
      can :see_owner, Claim do |claim|
        claim.user.try(:id) == user.id
      end
      cannot :add_consequence, Theorem
    else
      can :manage, Journey do |journey|
        journey.user_id == user.id
      end
      can :index, Theme
      can :show, Theme
      can :index, Argument
      can :import, Argument
      can :export, Argument
      can :import, Theme
    end

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
