require_relative "spec_helper"

describe "Reservation instantiation" do
  it "is an instance of Reservation " do
    trip = Reservation.new("dec 15, 2019", "dec 20, 2019")
    expect(trip).must_be_kind_of Reservation
  end

  it "raises an argument error if the checkout date is before the check in date" do
    trip = Reservation.new("dec 20, 2019", "dec 15, 2019")
    expect(trip).must_raise ArgumentError
  end
end
