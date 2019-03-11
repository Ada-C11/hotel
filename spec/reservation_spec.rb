require_relative "spec_helper"
describe "Reservation class" do
  it "Creates an instance of reservation" do
    reservation = Reservation.new
    expect(reservation).must_be_instance_of Reservation
  end
end
