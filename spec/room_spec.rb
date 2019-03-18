require_relative "spec_helper"

describe "Room" do
  describe "initialize" do
    before do
      @test_room = BookingSystem::Room.new(room_num: 1)
    end

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
      room_nums = (1..NUM_OF_ROOMS).to_a
      @rooms = BookingSystem::Room.make_rooms(room_nums)
    end

    it "creates an array of 20 instances of Room" do
      expect(@rooms).must_be_kind_of Array
      expect(@rooms.length).must_equal 20
      expect(@rooms[1]).must_be_kind_of BookingSystem::Room
    end
  end
end