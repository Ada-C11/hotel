require_relative "spec_helper"

# user can create a hotel block
# user can reserve rooms in hotel block

# hotel block has a date range
# hotel block has several rooms
# hotel block has discounted rate

describe "Reservation class" do
  it "can create Hotel Block" do
    block_reservation = Hotel::ReservationBlock.new(
      room_numbers: [1, 2, 3],
      in_date: Date.new(2019, 3, 15),
      out_date: Date.new(2019, 3, 17),
      discounted_percentage: 0.20,
      room_reservations: [{
        room_number: 5,
        in_date: Date.new(2019, 4, 15),
        out_date: Date.new(2019, 4, 17),
      },
                          {
        room_number: 6,
        in_date: Date.new(2019, 4, 15),
        out_date: Date.new(2019, 4, 17),
      }],
    )

    expect(block_reservation.date_range).must_equal Date.new(2019, 3, 15)...Date.new(2019, 3, 17)
    expect(block_reservation.block_of_rooms).must_equal [1, 2, 3]
    expect(block_reservation.discounted_rate).must_equal 0.8
  end

  it "will raise an exception if any room is unavailable for date range" do
    expect {
      Hotel::ReservationBlock.new(
        room_numbers: [1, 2, 3],
        in_date: Date.new(2019, 3, 15),
        out_date: Date.new(2019, 3, 17),
        discounted_percentage: 0.20,
        all_reservations: [{
          room_number: 3,
          in_date: Date.new(2019, 3, 15),
          out_date: Date.new(2019, 3, 17),
        },
                           {
          room_number: 6,
          in_date: Date.new(2019, 4, 15),
          out_date: Date.new(2019, 4, 17),
        }],
      )
    }.must_raise ArgumentError
  end
end
