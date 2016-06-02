class Role < ActiveRecord::Base
  belongs_to :user

  ROLES   = %W[viewer editor manager]
  MODELS  = %W{Agent Game}

  # validations
  validates :user_id, 
    presence:     true,
    numericality: { only_integer: true }

  validates :role,
    presence:     true

  validates :model,
    presence:     true

  validate :role_for_model_exists, on: :create

private
  def role_for_model_exists
    if Role.exists? user_id: user_id, model: model
      errors.add :user_id, "role for user_id and model already exists"
      errors.add :model, "role for user_id and model already exists"
    end
  end

 # on update only role can be upgraded/degraded
end
