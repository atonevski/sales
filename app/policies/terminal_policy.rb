class TerminalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.try(:admin?) or (user and Role.exists? user_id: user.id, model: 'Agent')
  end

  def update?
    user.try(:admin?) or
    (user and Role.exists? user_id: user.id, model: 'Agent', role: [:editor, :manager])
  end

  def create?
    user.try(:admin?) or
    (user and Role.exists? user_id: user.id, model: 'Agent', role: :manager)
  end

  def destroy?
    user.try(:admin?) or
    (user and Role.exists? user_id: user.id, model: 'Agent', role: :manager)
  end
end
