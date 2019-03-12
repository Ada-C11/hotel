require 'date'

require_relative 'spec_helper'

describe "list_rooms method" do
  it "provides a list of all rooms in the hotel" do
    hotel = Booking::Hotel.new

    expect(hotel.list_rooms).must_be_kind_of Array
    expect(hotel.list_rooms[4]).must_be_kind_of Booking::Room
    
  end
end

describe "add_reservation method" do
  before do
    checkin_date = Date.new(2019,1,4)
    checkout_date = Date.new(2019,1,7)
    @hotel = Booking::Hotel.new
    
    @reservation = Booking::Reservation.new(2, checkin_date, checkout_date)
  end

  it "adds the Reservation to a list of reservations" do
    @hotel.add_reservation(@reservation)
    expect(@hotel.all_reservations.length).must_equal 1
  end
end

describe "reservation_by_date" do 
  before do
    @checkin_date = Date.new(2019,1,4)
    @checkout_date = Date.new(2019,1,7)
    @hotel = Booking::Hotel.new
    
    @reservation = Booking::Reservation.new(2, @checkin_date, @checkout_date)

    @checkin_date2 = Date.new(2019,1,4)
    @checkout_date2 = Date.new(2019,1,8)
    
    @reservation2 = Booking::Reservation.new(2, @checkin_date, @checkout_date)
  end
  it "allows you to look up reservations by a specific date" do 
    @hotel.add_reservation(@reservation2)
    @hotel.add_reservation(@reservation)
    check = @hotel.reservations_by_date(@checkin_date)
    expect(check[0]).must_be_kind_of Booking::Reservation
    expect(check.length).must_equal 2
    expect(check[0].checkin_date).must_equal @checkin_date
  end
end

