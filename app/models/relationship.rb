class Relationship < ActiveRecord::Base
  self.inheritance_column = nil

  enum type: [:relative, :spouse, :children, :parental, :emergency]

  belongs_to :collaborator
  belongs_to :person

  accepts_nested_attributes_for :person

end
