require_relative "spec_helper"

describe "Room" do
  before do
    @test_hotel = BookingSystem::Hotel.new
    @test_room = BookingSystem::Room.new(room_num: 1)
  end
  
  describe "initialize" do
    it "creates an instance of Room" do
      expect(@test_room).must_be_kind_of BookingSystem::Room
    end

    it "costs $200 per Room per night" do
      expect(@test_room.price).must_equal 200
    end

    it "is instantiated with an empty array of reservations" do
      expect(@test_room.reservations).must_be_kind_of Array
      expect(@test_room.reservations.length).must_equal 0
    end
  end

  describe "make_rooms" do
    before do
      room_nums = (1..NUM_OF_ROOMS)
      @rooms = BookingSystem::Room.make_rooms(room_nums)
    end

    it "creates an array of 20 Rooms" do
      expect(@rooms).must_be_kind_of Array
      expect(@rooms.length).must_equal 20
    end

    it "creates instances of Room numbered 1 through 20" do
      expect(@rooms.first).must_be_kind_of BookingSystem::Room
      expect(@rooms.first.room_num).must_equal 1
      expect(@rooms.last).must_be_kind_of BookingSystem::Room
      expect(@rooms.last.room_num).must_equal 20
    end
  end

  # Tests for add_reservation grouped under hotel_spec#add_room
  
  describe "is_available?" do
    before do
      @jan1 = Date.new(2020, 1, 1)
      @jan2 = Date.new(2020, 1, 2)
      @jan3 = Date.new(2020, 1, 3)
      @jan4 = Date.new(2020, 1, 4)
      @jan5 = Date.new(2020, 1, 5)
      @test_res = @test_hotel.book_new_reservation(@test_room, @jan2, @jan4)
    end

    it "returns true for unreserved dates" do
      expect(@test_room.is_available?(@jan1)).must_equal true
      expect(@test_room.is_available?(@jan5)).must_equal true
    end

    it "returns false for reserved dates" do
      expect(@test_room.is_available?(@jan2)).must_equal false
      expect(@test_room.is_available?(@jan3)).must_equal false
    end

    # edge case of check-in on jan 4 must return true
  end
end