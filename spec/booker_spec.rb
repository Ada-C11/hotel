require_relative "spec_helper"
require "pry"

describe "Booker class" do
  describe "initialization" do
    before do
      @booker = Hotel::Booker.new
      @rooms = @booker.rooms
      @reservations = @booker.reservations
    end

    it "rooms is an array of rooms" do
      @rooms.each.with_index(1) do |room, i|
        expect(room).must_be_instance_of Hotel::Room
        expect(room.id).must_equal i
      end
      expect(@rooms).must_be_instance_of Array
      expect(@rooms.count).must_equal 20
    end

    it "reservations is an empty array" do
      expect(@reservations).must_equal []
    end
  end

  describe "reserve method" do
    before do
      @booker = Hotel::Booker.new
      start_date = "03-04-2019"
      end_date = "06-04-2019"
      @reservation = @booker.reserve(
        start_date: start_date,
        end_date: end_date,
      )
      @room = @reservation.room
    end

    it "creates a reservation" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it "reservation is in reservations array" do
      expect(@booker.reservations.include?(@reservation)).must_equal true
    end

    it "adds reservation to the room" do
      expect(@room.reservations.include?(@reservation)).must_equal true
    end

    it "room is available before reservation" do
      booker = Hotel::Booker.new
      start_date = "03-04-2019"
      end_date = "06-04-2019"
      date_range = Hotel::DateRange.new(start_date, end_date)
      assigned_room = booker.open_room(date_range)
      expect(assigned_room.is_available?(date_range)).must_equal true

      reservation = @booker.reserve(
        start_date: start_date,
        end_date: end_date,
      )
      room = reservation.room
      expect(room.object_id).must_equal assigned_room.object_id
    end

    it "room is unavailable after reservation" do
      date = @reservation.date_range
      open_rooms = @booker.available_rooms(date)
      expect((open_rooms.include?(@room))).must_equal false
    end

    it "reservation ids are unique" do
      booker = Hotel::Booker.new
      20.times do |i|
        reservation = booker.reserve(start_date: "03-04-2019", end_date: "06-04-2019")
        expect(reservation.id).must_equal i + 1
      end
    end

    it "raises an argument error if no available rooms" do
      booker = Hotel::Booker.new
      expect {
        21.times do
          booker.reserve(start_date: "03-04-2019", end_date: "06-04-2019")
        end
      }.must_raise ArgumentError
    end
  end

  describe "available_rooms" do
    # it "returns all avaialable rooms as an array" do
    #   available_rooms = booker.available_rooms()
    # end

    it "returns an empty array if no rooms available" do
      booker = Hotel::Booker.new
      20.times do
        booker.reserve(start_date: "03-04-2019", end_date: "06-04-2019")
      end
    end
  end
end
