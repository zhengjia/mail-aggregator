require_relative 'load_path'
require 'mongoid'
require 'db_connection'
require 'email'
require 'logger'

class Aggregator

  def sync(initial_sync = false)
    Mail.find(:order => initial_sync ? :asc : :desc, :count => :all) do |mail|
      # avoid incorrect encoding
      begin
        subject = mail.subject
        logger.info "Processing #{subject} sent on #{mail.date}"
      rescue ArgumentError, Encoding::UndefinedConversionError # ArgumentError => undefined encoding
        subject = ""
      end
      get_subjects.each do |subject_type|
        if subject =~ /#{subject_type}/i
          if Email.has_message_id?(mail.message_id)
            return unless initial_sync
          else
            logger.info "*******Storing #{mail.subject}***********"
            Email.store(mail)
          end
        end
      end
    end
  end

private

  def logger
    @logger ||= Logger.new(STDOUT)
  end

  def get_subjects
    @subjects ||= YAML::load File.open(File.expand_path('../subjects.yml', File.dirname(__FILE__) ) )
  end

end