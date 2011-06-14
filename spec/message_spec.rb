require 'spec_helper'
require 'message'

describe MailLib do

  it "can be created in the database" do
    Message.create(:message_id => "xxx@yyy.com",
                :date => Date.today,
                :subject => "this is a subject",
                :body => "this is a body")
    Message.all.count.should == 1
    Message.first.message_id.should == "xxx@yyy.com"
    Message.first.date.should == Date.today
    Message.first.subject.should == "this is a subject"
    Message.first.body.should == "this is a body"
    Message.first.status.should == "new"
    Message.first.show.should == true
  end

end