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
    @frontdesk = Hotel::Frontdesk.new
    @reservation = Hotel::Reservation.new("Amy Martinsen", "2015-05-20", 3)
    @block_res = Hotel::Reservation.new("Octavia Butler", "2019-07-08", 3, block_reference: "SCIFI PARTY")
    @frontdesk.request_block(@block_res, 2)
    @reservation3 = Hotel::Reservation.new("Amy Martinsen", "2019-07-08", 3, block_reference: "SCIFI PARTY")
  end
  it "calculates the correct cost for a regular reservation" do
    expect(@reservation.cost).must_equal 600
  end
  it "calculates the correct cost for a block reservation" do
    expect(@reservation3.cost).must_equal 450
  end
end
