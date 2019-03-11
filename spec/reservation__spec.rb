require_relative "spec_helper"

describe "Reservation class initialization" do
  it "will return an instance of reservation" do
    reservation = Reservation.new(1)
    expect(reservation).must_be_kind_of Reservation
  end

  it "check in date is nil unless values are given" do
    test_reserve = Reservation.new(1)
    expect(test_reserve.check_in).must_equal nil
  end

  it "check out date is nil unless values are given" do
    test_reserve = Reservation.new(1)
    expect(test_reserve.check_out).must_equal nil
  end
end

# describe "calculate total cost of reservation" do
#     it
# end
