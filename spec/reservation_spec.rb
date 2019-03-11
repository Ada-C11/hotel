require_relative "spec_helper"

describe "Reservation class" do
  it "is able to instantiate" do
    reservation = Reservation.new

    expect(reservation).must_be_kind_of Reservation
  end
end
