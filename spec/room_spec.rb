require_relative 'spec_helper'
require 'date'

describe "created room class" do
  it "is an instance of room" do
      room_id = 2
      checkin_date = Date.new(2019,1,4)
      checkout_date = Date.new(2019,1,7)
    room = Booking::Room.new(room_id)
    expect(room).must_be_kind_of Booking::Room
  end

  # it "adds the Reservation to a list of reservations" do
  #   room_id = 2
  #   Booking::Room.make_reservation(room_id)

  #   expect(Booking::Reservation.room_number).must_equal 2
  #   # checkin_date = Date.new(2019,1,4)
  #   # checkout_date = Date.new(2019,1,7)
  #   # reservation = Booking::Reservation.new(room_id, checkin_date, checkout_date)

  # end
end

# describe "total_cost method" do
#   before do
#     room_id = 2
#     checkin_date = Date.new(2019,1,4)
#     checkout_date = Date.new(2019,1,7)
#     @room = Booking::Room.new(room_id)
#   end
#   it "calculates total cost for room booking" do
#     expect(@room.total_cost).must_equal 600
#   end

#   it "does not count the checkout date in the cost calculations" do
#     expect(@room.checkout_date - @room.checkin_date).must_equal 3
#   end


# end
