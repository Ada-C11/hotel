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

describe "finds a reservation by date" do
  before do
    @res = Reservation.new(1, Date.new(2019, 3, 3), Date.new(2019, 3, 6))
  end

  it "includes_date? returns true for date within res date range" do
    date = Date.new(2019, 3, 4)

    expect(@res.includes_date?(date)).must_equal true
  end

  it "includes_date? returns false for date outside res date range" do
    date = Date.new(2019, 3, 7)

    expect(@res.includes_date?(date)).must_equal false
  end
end
