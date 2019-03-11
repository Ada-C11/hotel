require_relative 'spec_helper'
require 'date'

describe "created room class" do
  it "is an instance of room" do
      room_id = 2
      checkin_date = Date.new(2019,1,4)
      checkout_date = Date.new(2019,1,7)
    room = Booking::Room.new(room_id, checkin_date, checkout_date)
  expect(room).must_be_kind_of Booking::Room
  end
end

describe "total_cost method" do
  before do
    room_id = 2
    checkin_date = Date.new(2019,1,4)
    checkout_date = Date.new(2019,1,7)
    @room = Booking::Room.new(room_id, checkin_date, checkout_date)
  end
  it "calculates total cost for room booking" do
    expect(@room.total_cost).must_equal 600
  end

  it "does not count the checkout date in the cost calculations" do
    expect(@room.checkout_date - @room.checkin_date).must_equal 3
  end

end
