class AgentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.try(:admin?) or (user and Role.exists?(user_id: user.id, model: 'Agent'))
  end
  def update?
    user.try(:admin?) or
    (user and Role.exists?(user_id: user.id, role: [:editor, :manager], model: 'Agent'))
  end

  def create?
    user.try(:admin?) or
    (user and Role.exists?(user_id: user.id, role: [:manager], model: 'Agent'))
  end
end
