require_relative "spec_helper"
require_relative "../lib/hotel.rb"

describe "hotel class" do
  before do
    @hotel = HotelSystem::Hotel.new
  end
  describe "hotel instantiation" do
    it "will create a new hotel" do
      expect(@hotel).must_be_kind_of HotelSystem::Hotel
    end

    it "hotel will have an array of rooms and reservations" do
      expect(@hotel.rooms).must_be_kind_of Array
      expect(@hotel.reservations).must_be_kind_of Array
    end

    it "hotel will have an array of 20 unique rooms" do
      expect(@hotel.rooms[0]).must_be_kind_of HotelSystem::Room
      expect(@hotel.rooms[0].room_number).must_equal 1
      expect(@hotel.rooms.length).must_equal 20
      expect(@hotel.rooms[0].object_id).wont_equal @hotel.rooms[1].object_id
    end
  end

  describe "find_room method" do
    it "returns an instance of a room" do
      room = @hotel.find_room(19)

      expect(room).must_be_kind_of HotelSystem::Room
    end

    it "returns nil if a matching room isn't found" do
      room = @hotel.find_room(25)

      expect(room).must_be_nil
    end

    it "raises an ArgumentError if a bad room number is given" do
      expect {
        @hotel.find_room("cat")
      }.must_raise ArgumentError
    end
  end

  describe "reservation_dates method" do
    before do
      @dates = @hotel.reservation_dates(start_year: 19, start_month: 11, start_day: 15, num_nights: 5)
    end

    it "returns an array" do
      expect(@dates).must_be_kind_of Array
    end

    it "length of returned array is equal to number of nights + 1" do
      # Number of nights + 1 will include checkout day in dates
      expect(@dates.length).must_equal 6
    end

    it "must be an array of date class objects" do
      expect(@dates.first).must_be_kind_of Date
      expect(@dates.last).must_be_kind_of Date
    end

    it "first date in array is start date" do
      november_15_2019 = Date.new(19, 11, 15)

      expect(@dates.first).must_equal november_15_2019
    end

    it "last date in array is correct date" do
      november_20_2019 = Date.new(19, 11, 20)

      expect(@dates.last).must_equal november_20_2019
    end
  end

  describe "room_reserved? method" do
    it "will return false if the room is not reserved" do
      status = @hotel.room_reserved?(room_number: 19, dates: [[19, 12, 05], [19, 12, 06]])

      expect(status).must_equal false
    end
  end

  describe "find_available_room method" do
    it "will return a room if a room is available" do
      room = @hotel.find_available_room([[19, 12, 05], [19, 12, 06]])

      expect(room).must_be_kind_of HotelSystem::Room
     
    end

    it "will return the first available room" do
      room = @hotel.find_available_room([[19, 12, 05], [19, 12, 06]])
      expect(room.room_number).must_equal 1
    end
  end

  describe "reserve_room method" do
    before do
      @hotel.reserve_room(start_year: 19, start_month: 12, start_day: 5, num_nights: 4)
    end

    it "will add a reservation to the hotel's list of reservations" do
      expect(@hotel.reservations.length).must_equal 1
    end

    it "will correctly assign a reservation id" do
      @hotel.reserve_room(start_year: 19, start_month: 5, start_day: 5, num_nights: 4)

      expect(@hotel.reservations[1].id).must_equal 1
    end
  end
end
