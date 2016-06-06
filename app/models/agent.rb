class Agent < ActiveRecord::Base
  has_many :terminals, dependent: :delete_all
  has_many :sales

  validates :id, 
    presence:     true,
    numericality: { only_integer: true },
    uniqueness:   true

  validates :name,
    presence:   true,
    uniqueness: true
end
