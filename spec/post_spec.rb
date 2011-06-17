require 'spec_helper'
require 'post'

POST_STATUS = ['new', 'open', 'closed', 'awaiting']

describe Post do

  it "should be created in the database" do
    Post.create(:message_id => "xxx@yyy.com",
                :date => Date.today,
                :subject => "this is a subject",
                :body => "this is a body")
    Post.all.count.should == 1
    Post.first.message_id.should == "xxx@yyy.com"
    Post.first.date.should == Date.today
    Post.first.subject.should == "this is a subject"
    Post.first.body.should == "this is a body"
    Post.first.status.should == "new"
    Post.first.visible.should == true
  end

  it "should hide a post" do
    post = Fabricate(:post, :visible => true)
    post.visible.should == true
    post.hide
    post.reload
    post.visible.should == false
  end

  it "should show a post" do
    post = Fabricate(:post, :visible => false)
    post.visible.should == false
    post.show
    post.reload
    post.visible.should == true
  end

  it "should list visible posts" do
    post = Fabricate(:post, :visible => true)
    Post.list.count.should == 1
  end

  it "should not list invisible posts" do
    post = Fabricate(:post, :visible => false)
    Post.list.count.should == 0
  end

  it "should change post status" do
    post = Fabricate(:post, :status => POST_STATUS[0] )
    post.change_status(POST_STATUS[1])
    post.reload
    post.status.should == POST_STATUS[1]
  end

end