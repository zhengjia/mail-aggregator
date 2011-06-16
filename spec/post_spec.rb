require 'spec_helper'
require 'post'

describe Post do

  it "can be created in the database" do
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
    Post.first.show.should == true
  end

end