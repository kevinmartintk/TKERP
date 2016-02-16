class JobExperience < ActiveRecord::Base
  self.inheritance_column = nil

  enum type: [:practice, :full_time, :part_time, :freelance, :volunteering]

  belongs_to :collaborator
  belongs_to :reference, class_name: "Person"
  belongs_to :entity
  belongs_to :position

  accepts_nested_attributes_for :entity
  accepts_nested_attributes_for :reference

end
