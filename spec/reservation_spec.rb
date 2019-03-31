require_relative "spec_helper"

describe Reservation do
  it "calculates cost" do
    reservation = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    expect(reservation.calculate_cost).must_equal 400
  end

  it "raises an exception when end date is before start date" do
    expect { Reservation.new(start_date: "2019-05-03", end_date: "2019-04-05", room_number: 5) }.must_raise ArgumentError
  end

  it "raises an exception when start date and end date are the same" do
    expect { Reservation.new(start_date: "2019-05-03", end_date: "2019-05-03", room_number: 5) }.must_raise ArgumentError
  end
end
