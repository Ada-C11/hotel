require 'date'

require_relative 'spec_helper'

describe "create instance of Reservation class" do
  it "is an instance of Reservation" do
    room_id = 2
    checkin_date = Date.new(2019,1,4)
    checkout_date = Date.new(2019,1,7)
    reservation = Hotel::Reservation.new(room_id, checkin_date, checkout_date)
    expect(reservation).must_be_kind_of Hotel::Reservation
  end

  it "raises an error if checkout date is before checkin date" do 
    checkin_date = Date.new(2019,1,4)
    checkout_date = Date.new(2019,1,3)

    expect{Hotel::Reservation.new(2, checkin_date, checkout_date)}.must_raise ArgumentError
  end
end


describe "total_cost method" do
  before do
    room_id = 2
    checkin_date = Date.new(2019,1,4)
    checkout_date = Date.new(2019,1,7)
    @reservation = Hotel::Reservation.new(room_id, checkin_date, checkout_date)
  end
  it "calculates total cost for room booking" do
    expect(@reservation.total_cost).must_equal 600
  end

  it "does not count the checkout date in the cost calculations" do
    expect(@reservation.checkout_date - @reservation.checkin_date).must_equal 3
  end
end


