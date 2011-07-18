require 'mongoid'

class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: Date
  field :subject
  field :body
  field :visible, type: Boolean, default: true
  field :status, default: 'new'
  field :note
  
  # db.posts.ensureIndex({date:1})
  index :date, Mongo::ASCEDING

  scope :visible, where(:visible => true)

  belongs_to :email

  class << self

    def list
      Post.visible.order_by(:date)
    end

  end # end class methods

  def self.store(post_array)
    Post.create(:subject => post_array[0], :date => post_array[1], :body => post_array[2] )
  end

  def hide
    update_attribute(:visible, false) if visible == true
  end

  def show
    update_attribute(:visible, true) if visible == false
  end

  def change_status(status)
    update_attribute(:status, status) if self.status != status
  end

end
