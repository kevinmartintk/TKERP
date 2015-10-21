class Team

  attr_accessor :id, :name

  RUBY_MOBILE_TEAM_ID = 1
  PHP_TEAM_ID = 2
  ACCOUNTS_ID = 3

  def initialize(id, name)
  	@id = id
  	@name = name
  end

  def self.all
  	[ruby_mobile_team,php_team,accounts_team]
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

  def self.find id_tmp
		case id_tmp
		  when RUBY_MOBILE_TEAM_ID
		 		ruby_mobile_team
		 	when PHP_TEAM_ID
				php_team
			when ACCOUNTS_ID
				accounts_team
	  end  	
	end
end