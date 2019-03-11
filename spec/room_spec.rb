require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "Room class" do
  before do
    @room = Hotel::Room.new(room_number: 1)
  end
  it "creates an instance of Room" do
    expect(@room).must_be_kind_of Hotel::Room
  end

  it "includes an array when initialized" do
    expect(@room.reservations).must_be_kind_of Array
  end

  it "includes a cost per night" do
    expect(@room.cost_per_night).must_equal 200.00
  end
end
