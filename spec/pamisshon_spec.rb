# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Pamisshon do

  describe "prerequisites" do
  
    it "should get the current global environment var for testing" do
      Pamisshon::ENV.should_not be_nil
      Pamisshon::ENV.should     == 'spec'
    end
    
    it "should establish a basic Redis connection" do
      Redis.new.inspect.should =~ /connected to redis/
    end
    
  end
  
end



describe Pamisshon::Connection do

  it "should establish a connection" do
    Pamisshon::Connection.new.inspect.should =~ /connected to redis/
  end
  
  it "should be able to flush our keys only (#flush_keys)" do
    pc = Pamisshon::Connection.new
    pc.flush_keys
    ('a'..'z').each {|k| pc.set(k,1) }
    pc.keys.count.should == 26
    pc.flush_keys.should be_true
    pc.keys.count.should == 0
  end

end



describe Pamisshon::Permission do

  before do
    class User
      attr_accessor :name, :id
    end
    class Page
      attr_accessor :title,:id
    end
    
    @user = User.new; @user.name  = "asaaki";  @user.id = 1234
    @page = Page.new; @page.title = "My Page"; @page.id = 6789
    
    class User    
      def self.find(id)
        us = User.new
        us.name = "asaaki"
        us.id = 1234
        us
      end
    end
    class Page
      def self.find(id)
        pg = Page.new
        pg.title = "My Page"
        pg.id = 6789
        pg
      end
    end
  end
  
  context "#allow/#deny" do

    it "raise ArgumentError if not all values given" do
      pm = Pamisshon::Permission.new
      ->{pm.allow(@user, :read)}.should raise_error(ArgumentError)
      ->{pm.deny(User, :read)}.should raise_error(ArgumentError)
    end
    
    it "sets allow permission" do
      pm = Pamisshon::Permission.new
      pm.allow(@user, :read, @page).should == ["user/#{@user.id}/read/page/#{@page.id}","1"]
    end
    
    it "sets deny permission" do
      pm = Pamisshon::Permission.new
      pm.deny(User, :write, Page).should == ["user/__ALL__/write/page/__ALL__","0"]
    end
        
  end
  
  context "#retrieve" do
  
    it "returns a permission touple" do
      pm = Pamisshon::Permission.new
      user = User.find(1234)
      page = Page.find(6789)
      result = pm.retrieve("user/#{user.id}/read/page/#{page.id}","1")
      result[0].name.should == user.name
      result[1].should == :read
      result[2].title.should == page.title
      result[3].should == true
    end
    
  end
  
end

