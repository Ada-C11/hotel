require_relative 'spec_helper'

describe "HotelDispatcher class" do
  describe "HotelDispatcher instantiation" do
    before do
      @room = Hotel::Room.new(
        room_num: 15
      )
    end

    it "is an instance of Reservation" do
      expect(Hotel::HotelDispatcher.new).must_be_kind_of Hotel::HotelDispatcher
    end
    it "returns array of all the rooms" do
      hotel = Hotel::HotelDispatcher.new
      expect(hotel.list_all_rooms.length).must_equal 20
    end
    it "reserves a room" do
      new_booking = Hotel::HotelDispatcher.new
      expect(new_booking.reserve("2019-2-23", "2019-2-25")).must_be_kind_of Hotel::Reservation
    end

    it "returns all the reservations" do
      hotel = Hotel::HotelDispatcher.new
      hotel.reserve("2019-2-23", "2019-2-25")
      hotel.reserve("2019-3-1", "2019-3-6")
      expect(hotel.reservations.length).must_equal 2
    end

    it "returns reservations for a specified date" do
      hotel = Hotel::HotelDispatcher.new
      hotel.reserve("2019-2-23", "2019-2-25")
      hotel.reserve("2019-2-20", "2019-2-24")
      hotel.reserve("2019-2-10", "2019-2-27")
      expect(hotel.find_reservation("2019-2-23").length).must_equal 3
    end
  end
end