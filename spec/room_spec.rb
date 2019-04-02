require_relative "spec_helper"

describe "Room class" do
  describe "initialize method" do
    before do
      @new_room = HotelSystem::Room.new(id: 1, rate: 200)
    end
    it "initializes a room object" do
      expect(@new_room).must_be_instance_of HotelSystem::Room
    end
  end
  describe "reader methods" do
    before do
      @new_room = HotelSystem::Room.new(id: 1, rate: 200)
    end
    it "can retrieve room id" do
      expect(@new_room.id).must_equal 1
    end
    it "can retrieve room rate" do
      expect(@new_room.rate).must_equal 200
    end
    it "can retrieve room reservations" do
      expect(@new_room.reservations).must_be_instance_of Hash
      expect(@new_room.reservations).must_be_empty
    end
  end

  describe "is reserved" do
    before do
      @new_room = HotelSystem::Room.new(id: 1, rate: 200)
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "08 Feb 2020")
      @new_res = HotelSystem::Reservation.new(date_range: @date_range, room: @new_room, id: 1)
      @new_room.add_reservation(@new_res)
    end
    it "will return false if a room has no reservations overlapping with date range given" do
      test_range = HotelSystem::DateRange.new("01 Mar 2020", "08 Mar 2020")
      expect(@new_room.is_reserved?(test_range)).must_equal false
    end
    it "will return true if a room has reservations that overlap with date range given" do
      test_range = HotelSystem::DateRange.new("04 Feb 2020", "10 Feb 2020")
      expect(@new_room.is_reserved?(test_range)).must_equal true
    end
  end
end
