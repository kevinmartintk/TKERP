class Team
  
  attr_accessor :id, :name

  RUBY_MOBILE_TEAM_ID = 1
  PHP_TEAM_ID = 2
  ACCOUNTS_ID = 3
  MANAGEMENT_ID = 4
  DESIGN_ID = 5
  HUMAN_RESOURCES_ID = 6

  def initialize(id, name)
  	@id = id
  	@name = name
  end

  def self.all
  	[ruby_mobile_team,php_team,accounts_team, management_team, design_team, human_resources_team]
  end

  def self.ruby_mobile_team
  	new(RUBY_MOBILE_TEAM_ID, "RubyMobile")
  end

  def self.php_team
  	new(PHP_TEAM_ID, "PHP")
  end

  def self.accounts_team
  	new(ACCOUNTS_ID, "Accounts")
  end

  def self.management_team
    new(MANAGEMENT_ID, "Management")
  end

  def self.design_team
    new(DESIGN_ID, "Design")
  end

  def self.human_resources_team
    new(HUMAN_RESOURCES_ID, "Human Resources")
  end

  def self.find id_tmp
		case id_tmp
		  when RUBY_MOBILE_TEAM_ID
		 		ruby_mobile_team
		 	when PHP_TEAM_ID
				php_team
			when ACCOUNTS_ID
				accounts_team
      when MANAGEMENT_ID
        management_team
      when DESIGN_ID
        design_team
      when HUMAN_RESOURCES_ID
        human_resources_team
	  end  	
	end
end