
require_relative "spec_helper"

describe "Reservation" do
  let(:reservation_1) do
    reservation_id = 1
    start_time = Time.parse("2019-03-11 14:08:45 -0700")
    end_time = Time.parse("2019-03-15 14:08:45 -0700")
    room_number = 3
    status = "R"
    Hotel::Reservation.new(start_time, end_time, room_number, status: status, reservation_id: reservation_id)
  end
  it "is an instance of Reservation" do
    expect(reservation_1).must_be_instance_of Hotel::Reservation
  end

  it "can generate an id for the reservation" do
    expect(reservation_1.reservation_id).must_be_kind_of Integer
  end
  it "can calculate the amount of nights" do
    expect(reservation_1.total_nights).must_equal 4
    expect(reservation_1.total_nights).must_be_kind_of Integer
  end

  it "can calculate the cost" do
    expect(reservation_1.total_cost).must_equal 800
    expect(reservation_1.total_cost).must_be_kind_of Float
  end

  it "can calculate the cost with discount" do
    reservation_id = "puppies convention"
    start_time = Time.parse("2019-03-11 14:08:45 -0700")
    end_time = Time.parse("2019-03-15 14:08:45 -0700")
    room_number = 3
    status = "R"
    discount = 0.25
    block = Hotel::Reservation.new(start_time, end_time, room_number, status: status, reservation_id: reservation_id, discount: discount)
    expect(block.total_cost).must_equal 600
  end
end
