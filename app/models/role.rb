class Role < ActiveRecord::Base
  belongs_to :user

  ROLES = %W[viewer editor manager]
  MODELS = %W{Agent Game}

  # validations
  validates :user_id, 
    presence:     true,
    numericality: { only_integer: true }

  validates :role,
    presence:     true

  validates :model,
    presence:     true
end
