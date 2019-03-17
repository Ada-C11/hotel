require_relative "spec_helper"
require "awesome_print"

describe "Room class" do
  before do
    @room = Room.new(id: 1)
  end
  describe "Room instantiation" do
    it "is an instance of a room" do
      expect(@room).must_be_kind_of Room
      expect(Room).must_respond_to :hotel_rooms
    end
    it "creates 20 rooms upon instantiation" do
      expect(Room.hotel_rooms).must_be_kind_of Array
      expect(Room.hotel_rooms.length).must_equal 20
    end
    it "knows it's id" do
      expect(@room.id).must_equal 1
    end

    it "returns nil for a room that does not exist" do
      expect { Room.new(id: 1337) }.must_raise ArgumentError
    end
  end

  describe "booked_on" do
    before do
      @room = Room.new(id: 2)
    end
    it "knows what reservations it has" do
      reservation = Reservation.new(id: 1, room_booked: @room, dates_booked: (Date.parse("03/03/2020")...Date.parse("03/05/2020)")))
      expect(@room).must_respond_to :booked_on
      expect(@room.bookings).must_be_kind_of Array
      expect(@room).must_respond_to :bookings
    end
  end

  describe "room available?" do
    before do
      checkin = "March 9th 2020"
      checkout = "March 11th 2020"
      @room.booked_on(check_in: checkin, check_out: checkout)
    end

    it "books a room that has no bookings" do
      new_room = Room.new(id: 5)
      start = "March 3 2020"
      out = "March 6th 2020"

      expect(new_room.bookings.length).must_equal 0
      expect(new_room.bookings.empty?).must_equal true
      expect(new_room.room_available?(check_in: start, check_out: out)).must_equal true
      expect(new_room.bookings[0]).must_be_nil
    end

    it "allows you to book a room for an incoming date range that ends before any current bookings" do
      start = "March 3 2020"
      out = "March 6th 2020"

      expect(@room.room_available?(check_in: start, check_out: out)).must_equal true
    end

    it "allows you to book a room for an incoming date range that starts after any current bookings" do
      start = "March 12 2020"
      out = "March 14th 2020"
      expect(@room.room_available?(check_in: start, check_out: out)).must_equal true
    end

    it "allows you to book a room for an incoming checkout date that ends on the same day another reservation begins" do
      start = "March 7th 2020"
      out = "March 9th 2020"

      expect(@room.room_available?(check_in: start, check_out: out)).must_equal true
    end

    it "allows you to book a room for an incoming checkout date that ends on the same day another reservation begins" do
      start = "March 11th 2020"
      out = "March 12th 2020"

      expect(@room.room_available?(check_in: start, check_out: out)).must_equal true
    end

    it "will not allow a reservation that starts and ends on the same dates as a booking " do
      start = "March 9th 2020"
      out = "March 11th 2020"

      expect(@room.room_available?(check_in: start, check_out: out)).must_equal false
    end

    it "will not allow a reservation that occurs within a booked date range" do
      start = "March 10th 2020"
      out = "March 11th 2020"

      expect(@room.room_available?(check_in: start, check_out: out)).must_equal false
    end

    it "it will not allow a reservation that ends during a booked reservation" do
      start = "March 8th 2020"
      out = "March 10th 2020"

      expect(@room.room_available?(check_in: start, check_out: out)).must_equal false
    end

    it " will not allow a reservation that starts during a booked reservation" do
      start = "March 10th 2020"
      out = "March 15th 2020"

      expect(@room.room_available?(check_in: start, check_out: out)).must_equal false
    end

    it "will return false for an inquiry that conflicts with previous booking" do
      start = "March 8th 2020"
      out = "March 12th 2020"

      expect(@room.room_available?(check_in: start, check_out: out)).must_equal false
    end

    it "will book a room who has no bookings" do
      nil_bookings = Room.new(id: 13)
      day1 = "2019-10-03"
      day1b = "2019-10-04"

      expect(nil_bookings.room_available?(check_in: day1, check_out: day1b)).must_equal true
      nil_bookings.booked_on(check_in: day1, check_out: day1b)
      expect(nil_bookings.room_available?(check_in: day1, check_out: day1b)).must_equal false
    end
  end
end
