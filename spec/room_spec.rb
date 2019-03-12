require_relative 'spec_helper'
require 'date'

describe "created room class" do
  it "is an instance of room" do
    hotel = Booking::Hotel.new
      room_id = hotel.all_rooms.first.number
      checkin_date = Date.new(2019,1,4)
      checkout_date = Date.new(2019,1,7)
    room = Booking::Room.new(room_id)
    expect(room).must_be_kind_of Booking::Room
  end
end
