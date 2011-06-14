db_config = YAML::load File.open(File.expand_path('../mongoid.yml', File.dirname(__FILE__) ) )
RACK_ENV ||= 'development'
db_name = db_config[RACK_ENV]['database']
Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db(db_name)
end