require 'mongoid'
require 'db_connection'
require 'email'

class Aggregator

  def sync
    Mail.find(:what => :last) do |mail|
      get_subjects.each do |subject_type|
        if mail.subject =~ /#{subject_type}/i
          if Email.has_message_id?(mail.message_id)
            return
          else
            Email.store(mail)
          end
        end
      end
    end
  end

private

  def get_subjects
    @subjects ||= YAML::load File.open(File.expand_path('../subjects.yml', File.dirname(__FILE__) ) )
  end

end