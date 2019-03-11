require_relative "spec_helper"
describe "Reservation class" do
  it "Creates an instance of reservation" do
    reservation = Reservation.new
    expect(reservation).must_be_instance_of Reservation
  end
  it "Reservation class initialized with nil start  date if no date is given" do
    reservation = Reservation.new
    expect(reservation.start_date).must_equal nil
  end
  it "Reservation class initialized with nil  end date if no date is given" do
    reservation = Reservation.new
    expect(reservation.end_date).must_equal nil
  end
  it "Reservation id initialized as 0 if no reservation id is entered" do
    reservation = Reservation.new
    expect(reservation.reservation_id).must_equal 0
  end
end
