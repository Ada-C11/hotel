require_relative "spec_helper"

describe "room class" do
  before do
    @room = Room.new(1, 200)
  end
  it "returns an instance of class Room" do
    expect(@room).must_be_kind_of Room
    expect(@room.number).must_equal 1
    expect(@room.price).must_equal 200
  end

  it "prints out nicely" do
    expect(@room.print_nicely).must_equal "Room 1: $200.00 per night"
  end
end

describe "it knows about its own reservations" do
  before do
    @room = Room.new(1, 400)
    @room2 = Room.new(2, 400)

    @res = Reservation.new(1, Date.new(2019, 3, 10), Date.new(2019, 3, 12), @room)
    @res2 = Reservation.new(1, Date.new(2019, 4, 10), Date.new(2019, 4, 12), @room)

    @date = Date.new(2019, 3, 11)
  end

  it "adds a reservation to its @reservations array" do
    @room.add_reservation(@res)

    expect(@room.reservations.count).must_equal 1
    expect(@room.reservations[0].room.number).must_equal 1
  end

  it "returns true if it is available for a given date range" do
    @room.add_reservation(@res)
    @room.add_reservation(@res2)
    start_to_check = Date.new(2019, 5, 10)
    end_to_check = Date.new(2019, 5, 12)

    expect(@room.is_available?(start_to_check, end_to_check)).must_equal true
  end

  it "returns false if it is not available for a given date range" do
    @room.add_reservation(@res)
    @room.add_reservation(@res2)
    start_to_check = Date.new(2019, 3, 9)
    end_to_check = Date.new(2019, 3, 11)

    expect(@room.is_available?(start_to_check, end_to_check)).must_equal false
  end
end
