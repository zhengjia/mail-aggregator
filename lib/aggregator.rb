require 'mongoid'
require 'db_connection'
require 'email'
require 'post'

MESSAGE_STATUS = ['new', 'open', 'closed', 'awaiting']

class Aggregator

  def initial_sync
    Mail.all do |mail|
      get_subjects.each do |subject_type|
        if mail.subject =~ /#{subject_type}/i
          # store to db
          Email.store(mail)
        end
      end
    end
  end

  def resync

  end

  def list

  end

  def hide

  end

  def change_status

  end

  def destroy_email

  end

  def destroy_post

  end

private

  def get_subjects
    @subjects ||= YAML::load File.open(File.expand_path('../subjects.yml', File.dirname(__FILE__) ) )
  end


end