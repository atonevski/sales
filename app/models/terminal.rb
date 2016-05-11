class Terminal < ActiveRecord::Base
  belongs_to :agent
  
  validates :id, 
    presence:     true,
    numericality: { only_integer: true, greater_than: 0 },
    uniqueness:   true


  validates :name,
    presence:     true,
    allow_blank:  false,
    uniqueness:   true

end
