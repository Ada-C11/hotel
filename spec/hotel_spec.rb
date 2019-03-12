require_relative "spec_helper"

describe "Hotel class" do
  before do
    @new_hotel = HotelSystem::Hotel.new
  end
  describe "initialize" do
    it "initializes a Hotel object" do
      expect(@new_hotel).must_be_instance_of HotelSystem::Hotel
    end
    it "creates an array of Room objects" do
      expect(@new_hotel.rooms).must_be_instance_of Array
      @new_hotel.rooms.each do |room|
        expect(room).must_be_instance_of HotelSystem::Room
      end
    end
    it "creates an empty array of reservation objects" do
      expect(@new_hotel.reservations).must_be_instance_of Array
      expect(@new_hotel.reservations).must_be_empty
    end
  end
  describe "find room" do
    before do
      @new_hotel = HotelSystem::Hotel.new
    end
    it "will find a room when given a number between 1 and 20" do
      expect (@new_hotel.find_room_by_id(1)).must_be_instance_of HotelSystem::Room
    end
    it "will return nil if given an id that isn't between 1 and 20" do
      expect (@new_hotel.find_room_by_id(21)).must_be_nil
    end
  end
  describe "make reservation" do
    before do
      @new_hotel = HotelSystem::Hotel.new
      @new_res = @new_hotel.make_reservation(1, "01 Feb 2020", "08 Feb 2020")
      @test_room = @new_hotel.rooms.first
    end
    it "returns a new reservation if the room is available during the given dates" do
      expect(@new_res).must_be_instance_of HotelSystem::Reservation
    end

    it "adds the new reservation to the hotel's list of reservations" do
      expect(@new_hotel.reservations).must_include @new_res
    end

    it "adds the new reservation to the room's list of reservations" do
      expect(@test_room.reservations).must_include @new_res
    end

    it "returns nil if the room is not available during the given dates" do
      expect(@new_hotel.make_reservation(1, "01 Feb 2020", "08 Feb 2020")).must_be_nil
    end

    it "raises an ArgumentError if the dates given are invalid" do
      expect {
        @new_hotel.make_reservation(1, "08 Feb 2020", "01 Feb 2020")
      }.must_raise ArgumentError
    end
  end
  describe "list available rooms" do
    before do
      @new_hotel = HotelSystem::Hotel.new
      @total_rooms = @new_hotel.rooms.length
      @new_res = @new_hotel.make_reservation(1, "01 Feb 2020", "08 Feb 2020")
      @reserved_room = @new_hotel.find_room_by_id(1)
      @avail_rooms = @new_hotel.list_available_rooms("01 Feb 2020")
    end
    it "returns an array of rooms" do
      expect(@avail_rooms).must_be_instance_of Array
      @avail_rooms.each do |room|
        expect(room).must_be_instance_of HotelSystem::Room
      end
    end
    it "excludes reserved rooms" do
      expect(@avail_rooms).wont_include @reserved_room
      expect(@avail_rooms.length).must_equal (@total_rooms - 1)
    end
  end
end
