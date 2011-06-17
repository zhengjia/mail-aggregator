require_relative 'load_path'
require 'mongoid'
require 'db_connection'
require 'email'

class Aggregator

  def sync(initial = false)
    Mail.find(:what => initial ? :first : :last, :count => :all) do |mail|
      get_subjects.each do |subject_type|
        begin
          subject = mail.subject
        rescue ArgumentError, Encoding::UndefinedConversionError # ArgumentError => undefined encoding
          subject = ""
        end
        if subject =~ /#{subject_type}/i
          if Email.has_message_id?(mail.message_id)
            return unless initial
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