require 'parser'
require 'post'
require 'mail_lib'

class Email
  include Mongoid::Document
  include MailLib
  extend Parser
  field :message_id
  field :date, type: Date
  has_many :posts

  def self.store(mail)
    parent = Email.create(:message_id => mail.message_id, :date => mail.date.to_date)
    self.parse(mail) do |post_array|
      parent.posts << Post.store(post_array)
    end
  end

end
