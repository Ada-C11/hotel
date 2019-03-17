
require_relative "spec_helper"

describe "Reservation" do
  let(:reservation_1) do
    id = 1
    start_time = Time.parse("2019-03-11 14:08:45 -0700")
    end_time = Time.parse("2019-03-15 14:08:45 -0700")
    room_number = 3
    Hotel::Reservation.new(id, start_time, end_time, room_number)
  end
  it "is an instance of Reservation" do
    expect(reservation_1).must_be_instance_of Hotel::Reservation
  end

  it "can generate an id for the reservation" do
    expect(reservation_1.id).must_be_kind_of Integer
  end
  it "can calculate the amount of nights" do
    expect(reservation_1.total_nights).must_equal 4
    expect(reservation_1.total_nights).must_be_kind_of Integer
  end

  it "can calculate the cost" do
    expect(reservation_1.total_cost).must_equal 800
    expect(reservation_1.total_cost).must_be_kind_of Float
  end
end
