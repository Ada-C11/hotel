require_relative "spec_helper"

describe "Instantiation of Room" do
  before do
    @room = Hotel::Room.new(room_number: 2)
  end

  it "is an instance of Room class" do
    expect(@room).must_be_kind_of Hotel::Room
  end

  it "has a default cost of 200" do
    expect(@room.cost).must_equal 200
  end

  #   it "returns an Integer for room_number" do
  #     expect(@room.room_number).must_be_kind_of Integer
  #   end
  # end

  # describe "Availability of Room" do
  #   it "must take a date as a parameter" do
  #     expect(@room.availability("02-01-2000")).must_equal Date.parse
  #   end
end
