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
end
