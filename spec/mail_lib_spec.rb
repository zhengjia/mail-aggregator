require 'spec_helper'
require 'mail_lib'

describe MailLib do

  it "should set up retriever_method when the module is included" do
    cls = Class.new
    cls.class_eval do
      include MailLib
    end
    Mail.retriever_method.settings[:user_name].should_not be_nil
    Mail.retriever_method.settings[:password].should_not be_nil
  end

end