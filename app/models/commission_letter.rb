class CommissionLetter < ActiveRecord::Base
  belongs_to :user
  belongs_to :agent
end
