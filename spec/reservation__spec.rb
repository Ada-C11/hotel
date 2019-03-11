require_relative "spec_helper"

describe "test" do
  it "will return an instance of reservation" do
    reservation = Reservation.new(1, {}, "time", "time")
    expect(reservation).must_be_kind_of Reservation
  end
end
