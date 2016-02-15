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
  has_many :references, foreign_key: "reference_id", class_name: "Collaborator"
  has_many :collaborator_entities
  has_many :entities, through: :collaborator_entities
  has_many :studies
  has_many :relationships
  has_many :people, through: :relationships
  has_many :relative_relationships, -> { where(type: Relationship.types[:relative]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_many :relative, through: :relative_relationships, class_name: "Person"
  has_one :spouse_relationship, -> { where(type: Relationship.types[:spouse]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_one :spouse, through: :spouse_relationship, class_name: "Person"
  has_many :children_relationships, -> { where(type: Relationship.types[:children]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_many :children, through: :children_relationships, class_name: "Person"
  has_one :emergency_relationship, -> { where(type: Relationship.types[:emergency]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_one :emergency_contact, through: :emergency_relationship, class_name: "Person"
  has_many :job_experiences
  has_many :job_entities, through: :job_experiences, class_name: "Entity"
  has_one :collaborator_salary_bank, -> { where(type: CollaboratorEntity.types[:bank]) }, foreign_key: "collaborator_id", class_name: "CollaboratorEntity"
  has_one :salary_bank, through: :collaborator_salary_bank, class_name: "Entity"
  has_one :collaborator_cts_bank, -> { where(type: CollaboratorEntity.types[:bank]) }, foreign_key: "collaborator_id", class_name: "CollaboratorEntity"
  has_one :cts_bank, through: :collaborator_cts_bank, class_name: "Entity"
  has_one :collaborator_pension_entity, -> { where(type: CollaboratorEntity.types[:bank]) }, foreign_key: "collaborator_id", class_name: "CollaboratorEntity"
  has_one :pension_entity, through: :collaborator_pension_entity, class_name: "Entity"

  accepts_nested_attributes_for :spouse_relationship, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :spouse, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :children_relationships, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :job_experiences, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :job_entities, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :studies, reject_if: :all_blank, allow_destroy: true

  enum type: [:practice, :payroll, :professional]
  enum status: [:active, :inactive, :former, :expelled]
  enum blood_type: [:o_positive, :a_positive, :b_positive, :ab_positive, :o_negative, :a_negative, :b_negative, :ab_negative]
  enum insurance: [:fola, :eps]

  delegate :first_name, :last_name, :dni, :email, :birthday, :mobile, :phone, to: :person
  delegate :name, to: :team, prefix: true, allow_nil: true

  pg_search_scope :seek_name, against: [:name], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_last_name, against: [:last_name], using: { tsearch: { prefix: true  } }

  scope :team, -> (team_id) { where(team: team_id)}
  scope :team_name, -> (name) { joins("JOIN teams ON teams.name = '#{name}' AND teams.id = collaborators.id")}

  def full_name
    first_name + " " + last_name
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
