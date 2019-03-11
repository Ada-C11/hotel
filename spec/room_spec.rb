require_relative "spec_helper"

describe "room class" do
  before do
    @room = Room.new(1, 200)
  end
  it "returns an instance of class Room" do
    expect(@room).must_be_kind_of Room
    expect(@room.number).must_equal 1
    expect(@room.price).must_equal 200
  end

  it "availability defaults to :AVAILABLE" do
    expect(@room.availability).must_equal :AVAILABLE
  end

  it "raises an error if availability is set to invalid status" do
    expect { Room.new(1, 100, availability: :red) }.must_raise ArgumentError
  end

  it "prints out nicely" do
    expect(@room.print_nicely).must_equal "Room 1: $200.00 per night"
  end
end
