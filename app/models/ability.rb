class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.editor?
      can :manage, :all
      cannot :manage, User
      can :edit_theme, User
    else
      can :edit_theme, User do |other_user|
        other_user.id == user.id
      end
      cannot :manage, KnownTopic
      can :manage, KnownTopic do |known_topic|
        known_topic.user_id == user.id
      end
    end

  end
end
