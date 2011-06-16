require 'spec_helper'
require 'aggregator'

describe Aggregator do

  before(:each) do
    @aggregator = Aggregator.new
    @aggregator.stub(:get_subjects).and_return{ ["subject1", "subject2"] }
  end

  it "should save one mail with one message for initial_sync" do
    Mail.stub(:all).and_return{ [mail("subject1")] }
    @aggregator.initial_sync
    Email.all.count.should == 1
    Post.all.count == 1
  end

  it "should not save one mail with one message for initial_sync" do
    Mail.stub(:all).and_return{ [mail("bad subject")] }
    @aggregator.initial_sync
    Email.all.count.should == 0
    Post.all.count == 0
  end

  it "should not save two mail with multiple messages for initial_sync" do
    Mail.stub(:all).and_return{ [mail("subject1", 3), mail("subject2", 2)] }
    @aggregator.initial_sync
    Email.all.count.should == 2
    Post.all.count == 5
  end

  def mail(sub, times = 1)
    m = Mail.new do
      subject sub
      text_part do
        body mail_body * times
      end
    end
    m.date = Date.today
    m
  end

end