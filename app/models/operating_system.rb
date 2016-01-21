class OperatingSystem < ActiveRecord::Base
  enum category: [:desktop, :mobile, :wearable, :tv]
  alias_attribute :full_name, :name
  has_one :inventories
end
