class Agent < ActiveRecord::Base
  has_many :terminals

  validates :id, 
    presence:     true,
    numericality: { only_integer: true },
    uniqueness:   true

  validates :name,
    presence:   true,
    uniqueness: true
end
