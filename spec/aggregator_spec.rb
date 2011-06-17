require 'spec_helper'
require 'aggregator'

describe Aggregator do

  describe "sync" do

    before(:each) do
      @aggregator = Aggregator.new
      @aggregator.stub(:get_subjects).and_return{ ["subject1", "subject2"] }
    end

    it "should save a mail with a message" do
      Mail.stub(:find).and_yield( mail("subject1") )
      @aggregator.sync
      Email.all.count.should == 1
      Post.all.count == 1
    end

    it "should not save mail with bad subject" do
      Mail.stub(:find).and_yield( mail("bad subject") )
      @aggregator.sync
      Email.all.count.should == 0
      Post.all.count == 0
    end

    it "should save two mail with multiple messages" do
      Mail.stub(:find).and_yield( mail("subject1", 3) ).and_yield( mail("subject2", 2) )
      @aggregator.sync
      Email.all.count.should == 2
      Post.all.count == 5
    end

    it "should not save two mail with same message id" do
      Mail.stub(:find).and_yield( mail("subject1", 3, '123') ).and_yield( mail("subject2", 2, '123') )
      @aggregator.sync
      Email.all.count.should == 1
      Post.all.count == 3
    end

    def mail(sub, times = 1, msg_id = nil)
      m = Mail.new do
        subject sub
        message_id msg_id || rand.to_s
        text_part do
          body mail_body * times
        end
      end
      m.date = Date.today
      m
    end

  end

end