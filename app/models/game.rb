class Game < ActiveRecord::Base
  TYPES = %W{ INSTANT LOTTO NUMBER BINGO NEWSPAPER TOTO }

  # disable STI
  self.inheritance_column = :_type_disabled

  validates :name, presence: true
end
