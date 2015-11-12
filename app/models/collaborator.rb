class Collaborator < ActiveRecord::Base
  include PgSearch
  acts_as_paranoid
  has_many :events
  has_many :prospects

  pg_search_scope :seek_name, against: [:name], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_last_name, against: [:last_name], using: { tsearch: { prefix: true  } }

  def self.get_accounts
    where(:team => Team::ACCOUNTS_ID)
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
