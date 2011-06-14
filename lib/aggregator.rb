require 'mongoid'
require 'message'
require 'db_connection'

class Aggregator

  include MailLib

  def initialize
    setup_subjects
  end


private

  def setup_subjects
    SUBJECTS = YAML::load File.open(File.expand_path('../subjects.yml', File.dirname(__FILE__) ) )
  end

end