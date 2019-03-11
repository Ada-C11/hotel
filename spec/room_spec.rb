require "spec_helper"

describe "Room" do
  before do
    @room = Hotel::Room.new(1)
  end

  it "is an instance of Room" do
    expect(@room).must_be_instance_of Room
  end

  it "room id is an integer" do
    expect(@room.id).must_equal 1
  end

  it "sets reservations to an empty array if not provided" do
    expect(@room.reservations).must_be_kind_of Array
    expect(@room.reservations.length).must_equal 0
  end
end
