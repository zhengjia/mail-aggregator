require_relative 'load_path'
require 'parser'
require 'mail_lib'

class Email
  include Mongoid::Document
  include MailLib
  extend Parser
  field :message_id
  field :date, type: Date
  index :message_id, unique: true

  has_many :posts, :dependent => :destroy

  class << self

    def store(mail)
      parent = Email.create(:message_id => mail.message_id, :date => mail.date.to_date)
      self.parse(mail) do |post_array|
        parent.posts << Post.store(post_array)
      end
    end

    def has_message_id?(message_id)
      !Email.where(:message_id => message_id).empty?
    end

  end # end class methods

end
