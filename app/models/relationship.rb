class Relationship < ActiveRecord::Base
  self.inheritance_column = nil

  enum type: [:relative, :spouse, :children, :parental, :friend]

  belongs_to :collaborator
  belongs_to :person

  accepts_nested_attributes_for :person, reject_if: proc { |attributes| deep_blank?(attributes) }, allow_destroy: true

  def self.deep_blank?(hash)
    hash.each do |key, value|
      next if key == '_destroy'
      any_blank = value.is_a?(Hash) ? deep_blank?(value) : value.blank?
      return false unless any_blank
    end
    true
  end
end
