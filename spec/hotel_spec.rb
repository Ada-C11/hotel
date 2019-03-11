require 'spec_helper'
require_relative "../lib/hotel.rb"

describe "hotel instantiation" do
    before do 
        @hotel = HotelSystem::Hotel.new
    end

  it "will create a new hotel" do
    expect(@hotel).must_be_kind_of HotelSystem::Hotel
  end

  it "hotel will have an array of rooms and reservations" do
    expect(@hotel.rooms).must_be_kind_of Array 
    expect(@hotel.reservations).must_be_kind_of Array
  end

  it "hotel will have an array of 20 unique rooms" do
    expect(@hotel.rooms[0]).must_be_kind_of HotelSystem::Room
    expect(@hotel.rooms[0].room_number).must_equal 1
    expect(@hotel.rooms.length).must_equal 20
    expect(@hotel.rooms[0].object_id).wont_equal @hotel.rooms[1].object_id
  end
end

