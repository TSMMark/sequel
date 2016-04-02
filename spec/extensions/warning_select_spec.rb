require File.join(File.dirname(File.expand_path(__FILE__)), "spec_helper")

describe "Sequel::Plugins::WarningSelect" do

  before do
    @c = Class.new(Sequel::Model(:things))
  end

  it "should raise an error when type is :raise and 2 or more columns have the same name" do
    @c.plugin(:warning_select, :type => :raise)
    error = proc do
      @c.dataset.send(:columns=, [:id, :name, :id])
    end.must_raise(Sequel::Error)
    error.message.must_equal "tbd"
  end

  it "should print a message when type is not specified and 2 or more columns have the same name" do
    @c.plugin(:warning_select)
    proc do
      @c.dataset.send(:columns=, [:id, :name, :id])
    end.must_output("tbd\n")
  end

  it "should print a message when type is :print and 2 or more columns have the same name" do
    @c.plugin(:warning_select, :type => :print)
    proc do
      @c.dataset.send(:columns=, [:id, :name, :id])
    end.must_output("tbd\n")
  end

  it "should not raise any error when type is :raise and no columns have the same name" do
    @c.plugin(:warning_select, :type => :raise)
    @c.dataset.send(:columns=, [:id, :name])
  end

  it "should not print anything when type is not specified and no columns have the same name" do
    @c.plugin(:warning_select)
    proc do
      @c.dataset.send(:columns=, [:id, :name])
    end.must_be_silent
  end

  it "should not print anything when type is :print and no columns have the same name" do
    @c.plugin(:warning_select, :type => :print)
    proc do
      @c.dataset.send(:columns=, [:id, :name])
    end.must_be_silent
  end

end
