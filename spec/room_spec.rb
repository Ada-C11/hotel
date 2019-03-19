require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "Room class" do
  describe "Room initialize" do
    @room = Hotel::Room.new(1)
    before do
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "can return a room id" do
      expect(@room.room_id).must_equal 1
    end

    it "returns an array of reservations" do
      expect(@room.reservations).must_be_kind_of Array
    end
  end
end
