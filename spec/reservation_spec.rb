require_relative "spec_helper"

describe "Reservation class instatiations" do
  before do
    @new_reservation = Hotel::Reservation.new(
      phone_number: 1234567890,
      # number_of_rooms: 1,
      in_date: Date.new(2019, 3, 13),
      out_date: Date.new(2019, 3, 16),
    )
  end

  it "is an instance of reservation" do
    expect(@new_reservation).must_be_kind_of Hotel::Reservation
  end

  it "must have an ID that is 10 digits long" do
    expect do
      Hotel::Reservation.new(
        phone_number: 123456789,
        # number_of_rooms: 1,
        in_date: Date.new(2019, 3, 13),
        out_date: Date.new(2019, 3, 14),
      )
    end.must_raise ArgumentError
  end

  it "cannot have an out date that is before the in date" do
    expect do
      Hotel::Reservation.new(
        phone_number: 1234567890,
        # number_of_rooms: 1,
        in_date: Date.new(2019, 3, 14),
        out_date: Date.new(2019, 3, 13),
      )
    end.must_raise ArgumentError
  end

  # it "can calculate the number of nights" do
  #   expect(@new_reservation.total_number_of_nights).must_equal 3
  # end
end
