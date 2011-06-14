class Message
  include Mongoid::Document
  field :message_id
  field :date, type: Date
  field :subject
  field :body
  field :show, type: Boolean, default: true
  field :status, default: 'new'
end
