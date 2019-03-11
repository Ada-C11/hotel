require "simplecov"
SimpleCov.start

require_relative "spec_helper"
require_relative "../lib/room.rb"

describe "Room class" do
  it "creates an instance of Room" do
    expect(Hotel::Room.new(room_number: 1)).must_be_kind_of Hotel::Room
  end

  it "includes an array when initialized" do
    room = Hotel::Room.new(room_number: 1)

    expect(room.reservations).must_be_kind_of Array
  end
end
