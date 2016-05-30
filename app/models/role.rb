class Role < ActiveRecord::Base
  belongs_to :user

  TYPE = [:viewer, :editor, :manager]
end
