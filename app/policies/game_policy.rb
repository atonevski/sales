# require 'rails_helper'

class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.nil?
      return scope.all if user.admin?
      
      if Role.exists?(user_id: user.id, model: 'Game')
        scope.all
      else
        scope.none
      end
    end
  end

  def show?
    # if admin then everything allowed, else check logged in and have
    # at least viewer permissions for the Game model
    user.try(:admin?) or (user and Role.exists?(user_id: user.id, model: 'Game'))
  end

  def update?
    user.try(:admin?) or
    (user and Role.exists? user_id: user.id, model: Game, role: [:editor, :manager])
  end

end
