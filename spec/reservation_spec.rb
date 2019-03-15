require "date"
require_relative "spec_helper"

describe "Reservation.new" do
  before do
    @reservation = Hotel::Reservation.new("Amy Martinsen", "2015-05-20", 3)
  end
  it "creates and instance of Reservation" do
    expect(@reservation).must_be_instance_of Hotel::Reservation
  end
  it "calculates the correct checkout date" do
    expect(@reservation.checkout_date.to_s).must_equal "2015-05-23"
  end
  it "raises an ArgumentError for invalid dates" do
    expect { Hotel::Reservation.new("Amy Martinsen", "2015-05-20", 0) }.must_raise ArgumentError
  end
  it "has a block_reference default status of :UNAVAILABLE" do
    expect(@reservation.block_availability).must_equal :UNAVAILABLE
  end
end

describe "calucate_reserved_nights" do
  before do
    @reservation = Hotel::Reservation.new("Amy Martinsen", "2015-05-20", 3)
  end
  it "calculates and adds reserved nights to the reservation" do
    expect(@reservation.reserved_nights[1].to_s).must_equal "2015-05-21"
  end
end

describe "Reservation.cost method" do
  before do
    @reservation = Hotel::Reservation.new("Amy Martinsen", "2015-05-20", 3)
  end
  it "calculates the correct reservation cost" do
    expect(@reservation.cost).must_equal 600
  end
end
