# require 'rails_helper'

class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.try(:admin?) or (user and Role.exists?(user_id: user.id, model: 'Game'))
  end
end
