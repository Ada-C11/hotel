require_relative "spec_helper"

describe "Reservation initialization" do
  it "initializes a reservation when no keyword arguments are given" do
    my_rez = Reservation.new
    expect(my_rez.reservation_id).must_equal 0
    expect(my_rez.check_in_time).must_equal nil
    expect(my_rez.check_out_time).must_equal nil
  end
end

describe "duration_of_time" do
  it "must return an integer for duration of time" do
    my_rez = Reservation.new(reservation_id: 3, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")

    expect(my_rez.duration_of_stay).must_be_instance_of Integer
  end
end
