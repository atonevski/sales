# require 'rails_helper'

class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    # if admin then everything allowed, else check logged in and have at least viewer permissions
    # for the Game model
    user.try(:admin?) or (user and Role.exists?(user_id: user.id, model: 'Game'))
  end
end
