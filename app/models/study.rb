class Study < ActiveRecord::Base
  self.inheritance_column = nil

  enum type: [:technical, :superior, :posterior, :master, :doctor]
  enum degree: [:unfinished, :finished, :graduate, :bachelor, :certified]

  belongs_to :collaborator
  belongs_to :entity

end
