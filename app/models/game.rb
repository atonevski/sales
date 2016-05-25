class Game < ActiveRecord::Base
  has_many :categories, dependent: :delete_all

  TYPES = %W{ INSTANT LOTTO NUMBER BINGO NEWSPAPER TOTO }

  # disable STI
  self.inheritance_column = :_type_disabled

  # validations
  validate :parent_id_exists

  validates :id, 
    presence:     true,
    numericality: { only_integer: true },
    uniqueness:   true

  validates :name,
    presence:   true,
    uniqueness: true

  validates :type,
    presence:   true,
    inclusion:  { in: Game::TYPES }

  validates :parent,
    allow_nil:    true,
    allow_blank:  true,
    numericality: { only_integer: true }
  
  validates :volume,
    allow_nil:    true,
    allow_blank:  true,
    numericality: { only_integer: true }

  validates :price,
    presence:     true,
    numericality: { greater_than_or_equal_to: 0.5, only_integer: false }

  validates :commission,
    allow_nil:    true,
    numericality: { less_than: 1.0, greater_than_or_equal_to: 0.001 }
  
  private

  def parent_id_exists
    if parent.present? and not Game.exists?(parent)
      errors.add :parent, "does not exist"
    end
  end
end
