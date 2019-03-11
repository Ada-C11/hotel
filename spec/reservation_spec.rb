require "date"
require_relative "spec_helper"

describe "Reservation.new" do
  before do
    checkin_date = Date.parse("2015-05-20")
    @reservation = Hotel::Reservation.new("Amy Martinsen", checkin_date.to_s, 3)
  end
  it "creates and instance of Reservation" do
    expect(@reservation).must_be_instance_of Hotel::Reservation
  end
  it "calculates the correct reservation cost" do
    expect(@reservation.cost).must_equal 600
  end
  it "calculates the correct checkout date" do
    expect(@reservation.checkout_date.to_s).must_equal "2015-05-23"
  end

  it "checks raises an ArgumentError for invalid dates" do
    checkin_date = Date.parse("2015-05-20")
    expect do
      Hotel::Reservation.new("Amy Martinsen", checkin_date.to_s, 0)
    end.must_raise ArgumentError
  end
end
