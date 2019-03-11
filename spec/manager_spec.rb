require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "Manager class" do
  it "creates an instance of Manager" do
    expect(Hotel::Manager.new).must_be_kind_of Hotel::Manager
  end
end
