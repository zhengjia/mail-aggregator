require 'email'

class Post
  include Parser
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: Date
  field :subject
  field :body
  field :show, type: Boolean, default: true
  field :status, default: 'new'

  belongs_to :email

  def self.store(post_array)
    Post.create(:subject => post_array[0], :date => post_array[1], :body => post_array[2] )
  end

end
