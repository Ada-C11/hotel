require "simplecov"
SimpleCov.start

require_relative "spec_helper"
require_relative "../lib/room.rb"

describe "Room class" do
  it "creates an instance of Room" do
    expect(Hotel::Room.new).must_be_kind_of Hotel::Room
  end
end
