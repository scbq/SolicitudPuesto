class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # usuario invitado

    if user.admin?
      can :manage, :all # permisos completos para el administrador
    else
      can :read, JobOffer
      can :create, Application
      can :read, Application, user_id: user.id
    end
  end
end
