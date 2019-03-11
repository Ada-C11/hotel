require_relative "spec_helper"

describe "Reservation_manager instantiation" do
  it "is an instance of Reservation Manager" do
    guest = ReservationManager.new("Pfeiffer")
    expect(guest).must_be_kind_of ReservationManager
  end
end
