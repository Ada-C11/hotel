require "simplecov"
SimpleCov.start

require_relative "spec_helper"
require_relative "../lib/manager.rb"

describe "Manager class" do
  it "creates an instance of Manager" do
    expect(Hotel::Manager.new).must_be_kind_of Hotel::Manager
  end

  it "includes an array of rooms" do
    manager = Hotel::Manager.new

    expect(manager.rooms).must_be_kind_of Array
  end

  it "contains Room objects inside the rooms array" do
    manager = Hotel::Manager.new
    room = manager.rooms[0]

    expect(room).must_be_kind_of Hotel::Room
  end
end
