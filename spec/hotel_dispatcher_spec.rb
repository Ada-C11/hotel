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
      expect(hotel.rooms).must_be_kind_of Array
    end
    it "reserves a room" do
      hotel = Hotel::HotelDispatcher.new
      expect(hotel.reserve("2019-2-23", "2019-2-25")).must_be_kind_of Hotel::Reservation
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

    it "returns available rooms for a specific date" do
      hotel = Hotel::HotelDispatcher.new
      hotel.reserve("2019-2-21", "2019-2-26")
      hotel.reserve("2019-2-20", "2019-2-24")
      hotel.reserve("2019-2-10", "2019-2-27")
      expect(hotel.find_available_room("2019-2-21", "2019-2-25").length).must_equal 17
    end

    it "returns 0 if there are no available room" do
      hotel = Hotel::HotelDispatcher.new
      20.times do
      hotel.reserve("2019-2-21", "2019-2-26")
      end 
      expect(hotel.find_available_room("2019-2-21", "2019-2-26").length).must_equal 0
    end

    it "returns a message saying that there are no available rooms" do
      hotel = Hotel::HotelDispatcher.new
      20.times do
      hotel.reserve("2019-2-21", "2019-2-26")
      end 
      expect(hotel.reserve("2019-2-21", "2019-2-26")).must_equal nil
    end
  end
end