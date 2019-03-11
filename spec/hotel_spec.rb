require_relative "spec_helper"

describe "hotel class" do
  before do
    @hotel = Hotel.new
  end

  it "returns an object of type Hotel with instance variables" do
    expect(@hotel).must_be_kind_of Hotel
    expect(@hotel).must_respond_to :rooms, :reservations
  end

  it "initializes an array of rooms" do
    expect(@hotel.rooms).must_be_kind_of Array
    expect(@hotel.rooms.count).must_equal 20
  end
end

describe "list rooms and reservations" do
  before do
    @hotel = Hotel.new
    @hotel.rooms = [Room.new(3, 900)]
  end

  it "returns a formatted room" do
    expect(@hotel.list_rooms).must_equal "Room 3: $900.00 per night"
  end
end
