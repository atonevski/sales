class Category < ActiveRecord::Base
  belongs_to :games

  validates :category, # uniquenes inside game
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  validates :count,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  validates :amount,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
end
