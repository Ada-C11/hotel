require_relative "./spec_helper"

describe "Hotel" do
  before do
    rooms = (1..20)
    @test_hotel = BookingSystem::Hotel.new(rooms: rooms)
    @jan1 = Date.new(2020, 1, 1)
    @checkin = Date.new(2020, 1, 2)
    @jan3 = Date.new(2020, 1, 3)
    @checkout = Date.new(2020, 1, 4)
    @jan5 = Date.new(2020, 1, 5)
  end

  describe "initialize" do
    it "creates an instance of Hotel" do
      expect(@test_hotel).must_be_kind_of BookingSystem::Hotel
    end

    it "creates an array of Rooms numbered 1 through 20" do
      expect(@test_hotel.rooms).must_be_kind_of Array
      expect(@test_hotel.rooms.length).must_equal 20
      expect(@test_hotel.rooms.first).must_be_kind_of BookingSystem::Room
      expect(@test_hotel.rooms.first.room_num).must_equal 1
      expect(@test_hotel.rooms.last).must_be_kind_of BookingSystem::Room
      expect(@test_hotel.rooms.last.room_num).must_equal 20
    end
  end

  describe "add_room" do
    it "adds room into Hotel's array of rooms" do
      test_room = BookingSystem::Room.new(room_num: 1337)
      @test_hotel.add_room(test_room)
      expect(@test_hotel.rooms).must_be_kind_of Array
      expect(@test_hotel.rooms.first).must_be_kind_of BookingSystem::Room
      expect(@test_hotel.rooms.count).must_equal 21
      expect(@test_hotel.rooms.last.room_num).must_equal test_room.room_num
    end
  end

  describe "list_all_rooms" do
    it "returns an empty array if there is no room in the hotel" do
      rooms_not_specified = BookingSystem::Hotel.new
      expect(rooms_not_specified.list_all_rooms).must_be_kind_of Array
      expect(rooms_not_specified.list_all_rooms.length).must_equal 0
    end

    it "returns an array of all the rooms in the hotel" do
      all_rooms = @test_hotel.list_all_rooms
      expect(all_rooms).must_be_kind_of Array
      expect(all_rooms.count).must_equal 20
    end
  end

  describe "new_reservation" do
    before do
      @test_hotel.new_reservation(@test_hotel.rooms.first, @checkin, @checkout)
    end

    it "adds new reservation to Hotel's reservations" do
      expect(@test_hotel.reservations.first).must_be_kind_of BookingSystem::Reservation
      expect(@test_hotel.reservations.length).must_equal 1
    end

    it "adds new reservation to Room's reservations" do
      expect(@test_hotel.reservations[0]).must_be_kind_of BookingSystem::Reservation
      expect(@test_hotel.rooms.first.reservations.length).must_equal 1
    end
  end

  describe "list_by_date" do
    it "returns an empty array if there is no reservation on a given day" do
      expect(@test_hotel.reservations).must_be_kind_of Array
      expect(@test_hotel.reservations.length).must_equal 0
    end

    it "returns an array of all reservations on a given date" do
      @test_hotel.new_reservation(@test_hotel.rooms.first, @checkin, @checkout)
      reservations = @test_hotel.list_by_date(@checkin)
      expect(reservations).must_be_kind_of Array
      expect(reservations[0]).must_be_kind_of BookingSystem::Reservation
      expect(reservations.length).must_equal 1
    end
  end

  describe "list_available_rooms" do
    before do
      @test_res = @test_hotel.new_reservation(@test_hotel.rooms.first, @checkin, @checkout)
    end

     it "returns an array of all available rooms in the hotel" do
      same_days = @test_hotel.list_available_rooms(@checkin, @checkout)
      expect(same_days).must_be_kind_of Array
      expect(same_days.count).must_equal 19
      
      diff_days = @test_hotel.list_available_rooms(@jan1, @checkin)
      expect(diff_days).must_be_kind_of Array
      expect(diff_days.count).must_equal 20
    end

    it "raises an ArgumentError if there is no room available in the hotel" do
      # New hotel, with 1 room, and conflicting resolution
      new_hotel = BookingSystem::Hotel.new
      new_room = BookingSystem::Room.new(room_num: 1337)
      new_hotel.add_room(new_room)
      new_res = new_hotel.new_reservation(new_room, @checkin, @checkout)
      expect do
        new_hotel.list_available_rooms(@checkin, @checkout)
      end.must_raise ArgumentError
    end
  end
end