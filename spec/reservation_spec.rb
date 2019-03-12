require 'date'

require_relative 'spec_helper'

describe "create instance of Reservation class" do
  it "is an instance of Reservation" do
    room_id = 2
    checkin_date = Date.new(2019,1,4)
    checkout_date = Date.new(2019,1,7)
    reservation = Booking::Reservation.new(room_id, checkin_date, checkout_date)
    expect(reservation).must_be_kind_of Booking::Reservation
  end

  it "raises an error if checkout date is before checkin date" do 
    room_id = 2
    checkin_date = Date.new(2019,1,4)
    checkout_date = Date.new(2019,1,3)

    expect{booking = Booking::Reservation.new(2, checkin_date, checkout_date)}.must_raise ArgumentError
  end

  # it "is able to use the add_reservation method from Hotel class" do
  #   room_id = 2
  #   checkin_date = Date.new(2019,1,4)
  #   checkout_date = Date.new(2019,1,7)
  #   hotel = Booking::Hotel.new
  #   reservation = Booking::Reservation.new(room_id, checkin_date, checkout_date)

  #   # reservation.new_reservation

  # end

end

  # it "adds the Reservation to a list of reservations" do
  #   room_id = 2
  #   checkin_date = Date.new(2019,1,4)
  #   checkout_date = Date.new(2019,1,7)
  #   reservation = Booking::Reservation.new(room_id, checkin_date, checkout_date)

  #   expect{Booking::Hotel.all_rooms.length}.must_equal 1
  # end
# end
# describe "add_reservation method" do

#   it "adds the Reservation to a list of reservations" do
#     checkin_date = Date.new(2019,1,4)
#     checkout_date = Date.new(2019,1,7)
#     hotel = Booking::Hotel.new

    
#     reservation = Booking::Reservation.new(2, checkin_date, checkout_date)
#     hotel.add_reservation(reservation)
#     puts hotel.all_reservations

#     expect(hotel.all_reservations.length).must_equal 1

#   end
# end

describe "total_cost method" do
  before do
    room_id = 2
    checkin_date = Date.new(2019,1,4)
    checkout_date = Date.new(2019,1,7)
    @reservation = Booking::Reservation.new(room_id, checkin_date, checkout_date)
  end
  it "calculates total cost for room booking" do
    expect(@reservation.total_cost).must_equal 600
  end

  it "does not count the checkout date in the cost calculations" do
    expect(@reservation.checkout_date - @reservation.checkin_date).must_equal 3
  end

end

