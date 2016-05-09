class Category < ActiveRecord::Base
  belongs_to :games

  validates :category, # uniquenes inside game
    presence: true,
    numericality: { only_integer: true, greater_than: 0 },
    uniqueness: { scope: :game_id }

  validates :count,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  validates :amount,
    presence: true,
    numericality: { greater_than: 0 } # problems with validation: only_integer: true
end
