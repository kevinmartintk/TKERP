class Collaborator < ActiveRecord::Base
  self.inheritance_column = nil
  include PgSearch
  acts_as_paranoid

  belongs_to :person
  belongs_to :team
  belongs_to :referred_by, foreign_key: "reference_id", class_name: "Collaborator"

  has_many :events
  has_many :prospects
  has_many :inventories
  has_many :relationships
  has_many :studies
  has_many :people, through: :relationships
  has_many :relative_relationships, -> { where(type: Relationship.types[:relative]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_many :relative, through: :relative_relationships
  has_one :spouse_relationship, -> { where(type: Relationship.types[:spouse]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_one :spouse, through: :spouse_relationship
  has_many :children_relationships, -> { where(type: Relationship.types[:children]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_many :children, through: :children_relationships
  has_many :parental_relationships, -> { where(type: Relationship.types[:parental]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_many :parental, through: :parental_relationships
  has_one :emergency_relationship, -> { where(type: Relationship.types[:emergency]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_one :emergency_contact, through: :emergency_relationship
  has_many :job_experiences
  has_many :job_entities, through: :job_experiences
  has_many :references, foreign_key: "reference_id", class_name: "Collaborator"
  has_many :collaborator_entities
  has_many :entities, through: :collaborator_entities
  has_one :collaborator_salary_bank, -> { where(type: CollaboratorEntity.types[:bank]) }, foreign_key: "collaborator_id", class_name: "CollaboratorEntity"
  has_one :salary_bank, through: :collaborator_salary_bank
  has_one :collaborator_cts_bank, -> { where(type: CollaboratorEntity.types[:bank]) }, foreign_key: "collaborator_id", class_name: "CollaboratorEntity"
  has_one :cts_bank, through: :collaborator_cts_bank
  has_one :collaborator_pension_entity, -> { where(type: CollaboratorEntity.types[:bank]) }, foreign_key: "collaborator_id", class_name: "CollaboratorEntity"
  has_one :pension_entity, through: :collaborator_pension_entity

  accepts_nested_attributes_for :children_relationships
  accepts_nested_attributes_for :job_experiences
  accepts_nested_attributes_for :studies

  enum civil_status: [:single, :married, :widower, :divorced]
  enum gender: [:male, :female]
  enum type: [:practice, :payroll, :professional]
  enum status: [:active, :inactive, :former, :expelled]
  enum blood_type: [:o_positive, :a_positive, :b_positive, :ab_positive, :o_negative, :a_negative, :b_negative, :ab_negative]
  enum insurance: [:fola, :eps]

  pg_search_scope :seek_name, against: [:name], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_last_name, against: [:last_name], using: { tsearch: { prefix: true  } }

  scope :team, -> (team_id) { where(team: team_id)}
  scope :team_name, -> (name) { joins("JOIN teams ON teams.name = '#{name}' AND teams.id = collaborators.id")}

  def full_name
    name + " " + last_name
  end

  def team_name
    Team.find(team).nil? ? "-" : Team.find(team).name
  end

  def self.search_with name, last_name, month, start_date
    search_name(name).
    search_last_name(last_name).
    include_birthday(month).
    include_start_date(start_date)
  end

  def self.search_name name
    if name.present?
      seek_name(name)
    else
      order("created_at DESC")
    end       
  end

  def self.search_last_name last_name
    if last_name.present?
      seek_last_name(last_name)
    else
      order("created_at DESC")
    end       
  end

  def self.include_birthday month
    if month.present?
      where("extract(month from birthday) = ?", month)
    else
      order("created_at DESC")
    end 
  end

  def self.include_start_date start_date
    if start_date.present?
      where("extract(year from start_day) = ? AND extract(month from start_day) = ?", start_date.to_date.year, start_date.to_date.month)
    else
      order("created_at DESC")
    end 
  end
end
