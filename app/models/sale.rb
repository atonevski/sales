class Sale < ActiveRecord::Base
  belongs_to :terminal
  belongs_to :agent
  belongs_to :game
end
