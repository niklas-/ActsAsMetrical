ENV["RAILS_ENV"] = "test"
# set mysql
#ENV['DB'] ||= "mysql"

require File.expand_path('../../../../../config/environment', __FILE__)
require 'rails/test_help'
require 'rubygems'
require 'test/unit'
require 'active_support'


ActiveSupport::TestCase.fixture_path = File.dirname(__FILE__) + '/fixtures/'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #self.fixture_path = (Rails.root.to_s + "/vendor/plugins/acts_as_metrical/test/fixtures")
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

def load_schema 
  
  #config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
  # load rails projetc database
  config = YAML::load(IO.read(Rails.root.to_s + '/config/database.yml'))  
  ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")  
  
  db_adapter = ENV['DB'] 
  
  # no db passed, try one of these fine config-free DBs before bombing.  
  db_adapter ||= 
    begin 
      
      require 'rubygems'  
      require 'sqlite'  
      'sqlite'  
    rescue MissingSourceFile 
      begin 
        require 'sqlite3'  
        'sqlite3'  
      rescue MissingSourceFile 
      end
    end  
    
  if db_adapter.nil? 
    raise "No DB Adapter selected. Pass the DB= option to pick one, or install Sqlite or Sqlite3."  
  end  
    
  ActiveRecord::Base.establish_connection(config[db_adapter])  
  load(File.dirname(__FILE__) + "/schema.rb") 
  require File.dirname(__FILE__) + '/fixtures/metric_thing' 
  #require File.dirname(__FILE__) + '/../rails/init'

end 