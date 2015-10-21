class Collaborator < ActiveRecord::Base
  acts_as_paranoid
  has_many :events

  searchable do
    text :name
    text :last_name
    integer :birthday_month do |collaborator|
      collaborator.birthday.month
    end
    date :start_date do |collaborator|
      collaborator.start_day.change(day: 1)
    end
  end

  def self.get_accounts
    where(:team => Team::ACCOUNTS_ID)
  end

  def team_name
    Team.find(team).nil? ? "-" : Team.find(team).name
  end
end
