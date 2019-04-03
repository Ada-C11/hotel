
require "spec_helper"

describe "Reservation class" do
  it "can create a reservation" do
    room_reservation = Hotel::Reservation.new(
      room_number: 1,
      in_date: Date.new(2019, 3, 15),
      out_date: Date.new(2019, 3, 17),
      block_reservations: [{
        room_numbers: [2, 3, 4, 5, 6],
        in_date: Date.new(2019, 4, 15),
        out_date: Date.new(2019, 4, 17),
        discounted_percentage: 0.2,
      }],
    )

    expect(room_reservation.date_range).must_equal Date.new(2019, 3, 15)...Date.new(2019, 3, 17)
    expect(room_reservation.room_number).must_equal 1
  end

  it "will raise an exception if any room is unavailable for date range" do
    expect {
      Hotel::Reservation.new(
        room_number: 1,
        in_date: Date.new(2019, 3, 15),
        out_date: Date.new(2019, 3, 17),
        block_reservations: [{
          room_numbers: [1, 2, 3, 4, 5, 6],
          in_date: Date.new(2019, 3, 15),
          out_date: Date.new(2019, 3, 17),
          discounted_percentage: 0.2,
        }],
      )
    }.must_raise ArgumentError
  end

  it "cannot book a room that is in a reservation block for a specific date" do
  end
end
