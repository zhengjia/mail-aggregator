require_relative 'load_path'
require 'mongoid'
require 'parser'
require 'mail_lib'
require 'helper'
require 'post'

class Email
  include Mongoid::Document
  include MailLib
  extend Parser
  field :subject
  field :message_id
  field :date, type: Date
  index :message_id, unique: true

  has_many :posts, :dependent => :destroy

  class << self

    def store(mail)
      parent = Email.create(:message_id => mail.message_id, :date => mail.date.to_date, :subject => Helper.force_encoding(mail.subject) )
      self.parse(mail) do |post_array|
        parent.posts << Post.store(post_array)
      end
    end

    def has_message_id?(message_id)
      !Email.where(:message_id => message_id).empty?
    end

  end # end class methods

end
