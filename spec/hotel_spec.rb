require_relative "./spec_helper"

describe "Hotel" do
  before do
    @test_hotel = BookingSystem::Hotel.new
    @test_room = BookingSystem::Room.new(room_num: 1337)
  end

  describe "initialize" do
    it "creates an instance of Hotel" do
      expect(@test_hotel).must_be_kind_of BookingSystem::Hotel
    end
  end

  describe "add_room" do
    it "adds room into Hotel's array of rooms" do
      @test_hotel.add_room(@test_room)
      expect(@test_hotel.rooms).must_be_kind_of Array
      expect(@test_hotel.rooms[0]).must_be_kind_of BookingSystem::Room
      expect(@test_hotel.rooms.count).must_equal 1
      expect(@test_hotel.rooms[-1].room_num).must_equal @test_room.room_num
    end
  end

  describe "list_rooms" do
    it "returns nil if there is no room in the hotel" do
      expect(@test_hotel.list_rooms).must_be_kind_of Array
      expect(@test_hotel.list_rooms.length).must_equal 0
    end

    it "returns an array of all the rooms in the hotel" do
      @test_hotel.add_room(@test_room)
      all_rooms = @test_hotel.list_rooms
      expect(all_rooms).must_be_kind_of Array
      expect(all_rooms.count).must_equal 1
    end
  end

  describe "new_reservation" do
    before do
      checkin_date = Date.new(2019, 1, 1)
      checkout_date = Date.new(2019, 1, 11)
      @test_hotel.new_reservation(@test_room, checkin_date, checkout_date)
    end

    it "adds new reservation to Hotel's reservations" do
      expect(@test_hotel.reservations[0]).must_be_kind_of BookingSystem::Reservation
      expect(@test_hotel.reservations.length).must_equal 1
    end

    it "adds new reservation to Room's reservations" do
      expect(@test_hotel.reservations[0]).must_be_kind_of BookingSystem::Reservation
      expect(@test_room.reservations.length).must_equal 1
    end
  end

  describe "list_by_date" do
    before do
      checkin_date = Date.new(2019, 1, 1)
      checkout_date = Date.new(2019, 1, 11)
      @test_hotel.new_reservation(@test_room, checkin_date, checkout_date)
    end

    it "returns an array of all reservations on a given date" do
      reservations = @test_hotel.list_by_date(Date.new(2019, 1, 1))
      expect(reservations).must_be_kind_of Array
      expect(reservations[0]).must_be_kind_of BookingSystem::Reservation
      expect(reservations.length).must_equal 1
    end
  end
end