require_relative "spec_helper"

describe "reservation class" do
  before do
    @res = Reservation.new(1, Date.new(2019, 3, 10), Date.new(2019, 3, 12))
  end
  it "returns an instance of class Reservation" do
    expect(@res).must_be_kind_of Reservation
  end

  it "finds total price based on number of days in reservation" do
    @res.room = Room.new(21, 200)
    expect(@res.find_total_price).must_equal 400
  end

  it "returns a Room from find_room method" do
    expect(@res.find_room).must_be_kind_of Room
  end
end
