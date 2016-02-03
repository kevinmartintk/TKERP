class Team < ActiveRecord::Base
  has_many :inventories
  has_many :collaborators
end