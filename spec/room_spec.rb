require_relative "spec_helper"

describe "Room class" do
  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new(
        room_number: 1,
        reservations: nil,
      )
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "throws an argument error with an invalid room number" do
      expect { Hotel::Room.new(id: 0) }.must_raise ArgumentError
    end

    it "sets reservations to an empty array if no reservations have occurred" do
      expect(@room.reservations).must_be_kind_of Array
      expect(@room.reservations.length).must_equal 0
    end
  end

  describe "Add Reservation method" do
    before do
      @concierge = Hotel::Concierge.new
      @room = @concierge.all_rooms[2]
      @count = @room.reservations.length
      @reservation = Hotel::Reservation.new(id: 20, room: 3, start_date: "2019-04-01", end_date: "2019-04-05")
      @room.add_reservation(@reservation)
    end

    it "updates the room's list of reservations" do
      expect(@room.reservations.length).must_equal @count + 1
      expect(@room.reservations).must_be_kind_of Array
      expect(@room.reservations[0]).must_be_instance_of Hotel::Reservation
      expect(@room.reservations[0].id).must_equal 20
    end
  end
end # Room class
