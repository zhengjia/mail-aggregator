require 'spec_helper'
require 'parser'

describe Parser do

  before(:each) do
    @class = Class.new do
      extend Parser
    end
  end

  it "can parse mail with 0 post" do
    msg = %{
      // xxx xxx\n// xxxx\n\nhttp://xxx.com/xxx\nloremLorem ipsum\n deserunt mollit anim \nid est laborum.\n\nCreate an Account: \nhttps://www.feedmyinbox.com/account/create/194661//?utm_source=fmi&utm_medium=email&utm_campaign=feed-email\n\nUnsubscribe here: \nhttp://www.feedmyinbox.com/feeds/unsubscribe/?utm_source=fmi&utm_medium=email&utm_campaign=feed-email\n\n--\nThis email was carefully delivered by FeedMyInbox.com. \nPO Box 682532 Franklin, TN 37068
    }
    @class.parse(mail(msg)) do |post_array|
      post_array.length.should == 3
      post_array[0].should == "xxx xxx"
      post_array[1].should == Date.today
      post_array[2].should match /deserunt mollit anim id est laborum/
    end
  end

  it "can yield multiple times for mails with multiple posts" do
    msg = "// yyy (xxx)\n// June 13, 2011 at 3:18 PM \n\n Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n\n\n\n// ccc\n// June 13, 2011 at 3:18 PM\n\n Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n Create an Account: \nhttps://www.feedmyinbox.com/account/create/5992/?utm_source=fmi&utm_medium=email&utm_campaign=feed-email\n\nUnsubscribe here: \nhttp://www.feedmyinbox.com/feeds/unsubscribe/6ccd7/?utm_source=fmi&utm_medium=email&utm_campaign=feed-email\n\n--\nThis email was carefully delivered by FeedMyInbox.com. \nPO Box 682532 Franklin, TN 37068"
    count = 0
    @class.parse(mail(msg)) do |post_array|
      count += 1
      post_array.length.should == 3
    end
    count.should == 2
  end

  def mail(msg)
    m = Mail.new do
      text_part do
        body msg
      end
    end
    m.date = Date.today
    m
  end
end