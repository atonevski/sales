class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.try(:admin?) or (user and Role.exists? user_id: user.id, model: 'Game')
  end

  def update?
    user.try(:admin?) or
    (user and Role.exists? user_id: user.id, model: 'Game', role: [:editor, :manager])
  end

  def create?
    user.try(:admin?) or
    (user and Role.exists? user_id: user.id, model: 'Game', role: :manager)
  end

  def destroy?
    user.try(:admin?) or
    (user and Role.exists? user_id: user.id, model: 'Game', role: :manager)
  end
end
