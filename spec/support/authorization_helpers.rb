module AuthorizationHelpers
  def assign_role!(user, role, model)
    Role.where(user: user, model: model).delete_all
    Role.create!(user: user, role: role, model: model)
  end
end

RSpec.configure do |c|
  c.include AuthorizationHelpers
end
