require_relative "spec_helper"

describe "Room" do
  describe "initialize" do
    before do
      @new_room = HotelSystem::Room.new(id: 1)
    end
    it "Can initialize a new object of class Room" do
      expect(@new_room).must_be_kind_of HotelSystem::Room
    end

    it "Creates a room with default parameters" do
      expect(@new_room.reservations).must_equal []
      expect(@new_room.price_per_night).must_equal 200
    end
  end
  describe "available?" do
    before do
      @room = HotelSystem::Room.new(id: 1)
      reservation1 = HotelSystem::Reservation.new(room: @room, arrive_day: Date.parse("2005-12-15"), depart_day: Date.parse("2005-12-30"))
      reservation2 = HotelSystem::Reservation.new(room: @room, arrive_day: Date.parse("2006-11-15"), depart_day: Date.parse("2006-12-16"))
      @room.reservations << reservation1
      @room.reservations << reservation2
    end

    it "returns False if room is unavailable for a specific day" do
      expect(@room.available?(Date.parse("2005-12-15"))).must_equal false
      expect(@room.available?(Date.parse("2005-12-29"))).must_equal false
      expect(@room.available?(Date.parse("2006-11-29"))).must_equal false
    end

    it "Returns True if room is available for a specific date" do
      expect(@room.available?(Date.parse("2007-12-15"))).must_equal true
      expect(@room.available?(Date.parse("2005-12-30"))).must_equal true
      expect(@room.available?(Date.parse("2006-11-14"))).must_equal true
    end
  end

  describe "self.create_rooms" do
    before do
      room_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
      @rooms = HotelSystem::Room.create_rooms(room_numbers)
    end

    it "Creates an array of the correct length" do
      expect(@rooms).must_be_kind_of Array
      expect(@rooms.length).must_equal 20
    end

    it "Creates an array of Room instances" do
      expect(@rooms.first).must_be_kind_of HotelSystem::Room
      expect(@rooms.last).must_be_kind_of HotelSystem::Room
    end
  end
end
