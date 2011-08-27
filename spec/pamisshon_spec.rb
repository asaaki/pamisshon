# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Pamisshon do

  describe "prerequisites" do
  
    it "should get the current global environment var for testing" do
      Pamisshon::ENV.should_not be_nil
      Pamisshon::ENV.should     == 'development'
    end
    
    it "should establish a basic Redis connection" do
      Redis.new.inspect.should =~ /connected/
    end
  
  end
  
end

