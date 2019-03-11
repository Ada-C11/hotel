require_relative "spec_helper"

describe "Reservation class" do
  it "initializes a reservation when no keyword arguments are given" do
    my_rez = Reservation.new
    expect(my_rez.reservation_id).must_equal 0
    expect(my_rez.check_in_time).must_equal nil
    expect(my_rez.check_out_time).must_equal nil
  end
end
