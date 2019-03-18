require_relative "./spec_helper"

describe "Hotel" do
  before do
    @test_hotel = BookingSystem::Hotel.new
    @test_room = BookingSystem::Room.new(room_num: 1337)
    @checkin = Date.new(2020, 1, 2)
    @checkout = Date.new(2020, 1, 4)
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

  describe "list_all_rooms" do
    it "returns an empty array if there is no room in the hotel" do
      expect(@test_hotel.list_all_rooms).must_be_kind_of Array
      expect(@test_hotel.list_all_rooms.length).must_equal 0
    end

    it "returns an array of all the rooms in the hotel" do
      @test_hotel.add_room(@test_room)
      all_rooms = @test_hotel.list_all_rooms
      expect(all_rooms).must_be_kind_of Array
      expect(all_rooms.count).must_equal 1
    end
  end

  describe "new_reservation" do
    before do
      @test_hotel.new_reservation(@test_room, @checkin, @checkout)
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
    it "returns an empty array if there is no reservation on a given day" do
      expect(@test_hotel.reservations).must_be_kind_of Array
      expect(@test_hotel.reservations.length).must_equal 0
    end

    it "returns an array of all reservations on a given date" do
      @test_hotel.new_reservation(@test_room, @checkin, @checkout)
      reservations = @test_hotel.list_by_date(@checkin)
      expect(reservations).must_be_kind_of Array
      expect(reservations[0]).must_be_kind_of BookingSystem::Reservation
      expect(reservations.length).must_equal 1
    end
  end

  describe "overlap?" do
    before do
      @test_hotel.new_reservation(@test_room, @checkin, @checkout)
    end

    it "returns true for a room with no reservation on a given day" do
      expect(@test_hotel.overlap?(Date.new(1776, 7, 4))).must_equal false
    end

    it "returns false for a room that is booked on a given day" do
      expect(@test_hotel.overlap?(@checkin)).must_equal true
    end
  end

  describe "list_available_rooms" do
    before do
      @before_checkin = Date.new(2020, 1, 1)
      @in_between = Date.new(2020, 1, 3)
      @after_checkout = Date.new(2020, 1, 5)
    end

    it "raises an ArgumentError if there is no room in the hotel" do
      expect do
        @test_hotel.list_available_rooms(@checkin)
      end.must_raise ArgumentError
    end

    it "raises an ArgumentError for overlaping booking" do
      # starts before, ends during
      # starts during, ends after
      # starts on checkin, ends on checkout
      # starts before, ends on checkout
      # starts on checkin, ends after
      # starts during, ends during
      # starts before and ends after
      # starts during, ends on checkout
      # starts on checkin, ends during
    end

    it "returns array of available rooms for OK cases" do
      # starts before, ends on checkin
      # starts before, ends before
      # starts on checkout, ends after
      # starts after, ends after
    end

    # it "raises an ArgumentError if there is no available room in the hotel" do
    #   @test_hotel.add_room(@test_room)
    #   # Conflicting date
    #   @test_hotel.new_reservation(@test_room, @checkin, @checkout)
    #   expect do
    #     @test_hotel.list_available_rooms(@checkin)
    #   end.must_raise ArgumentError
    # end

    # it "returns an array of all available rooms in the hotel" do
    #   @test_hotel.add_room(@test_room)

    #   @test_hotel.new_reservation(@test_room, @checkin + 100, @checkout + 100)
    #   available_rooms = @test_hotel.list_available_rooms(@checkin)
    #   expect(available_rooms).must_be_kind_of Array
    #   expect(available_rooms.count).must_equal 1

    #   # Now has two available rooms
    #   new_room_with_no_reservation = BookingSystem::Room.new(room_num: 1)
    #   @test_hotel.add_room(new_room_with_no_reservation)
    #   two_available_rooms = @test_hotel.list_available_rooms(@checkin)
    #   expect(two_available_rooms).must_be_kind_of Array
    #   expect(two_available_rooms.count).must_equal 2
    #   # -1's room_num must match
    # end
  end
end