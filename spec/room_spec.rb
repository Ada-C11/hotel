require_relative "spec_helper"

describe "Room" do
  describe "initialize" do
    it "can be instantiated" do
      expect(Hotel::Room.new(1)).must_be_instance_of Hotel::Room
    end

    it "has attributes of the right data types" do
      room = Hotel::Room.new(1)
      expect(room.room_id).must_be_kind_of Integer
      expect(Hotel::Room.cost).must_be_kind_of Float
    end
  end
end
