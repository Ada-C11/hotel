require_relative "spec_helper"

describe "Reservation instantiation" do
  it "is an instance of Reservation " do
    trip = Hotel::Reservation.new(5, "dec 15, 2019", "dec 20, 2019")
    expect(trip).must_be_kind_of Hotel::Reservation
  end

  it "raises an argument error if the checkout date is before the check in date" do
    expect { Hotel::Reservation.new(1, "dec 20, 2019", "dec 15, 2019") }.must_raise ArgumentError
  end
end

describe "total_cost method" do
  it "Calculates the total cost of the reservation" do
    trip = Hotel::Reservation.new(2, "dec 15, 2019", "dec 20, 2019")
    expect(trip.reservation_cost).must_equal 1000
  end
end
