require_relative "spec_helper"

describe "Room" do
  describe "initialize" do
    it "can be instantiated" do
      expect(Hotel::Room.new(room_id: 1)).must_be_instance_of Hotel::Room
    end

    it "has attributes of the right data types" do
      room = Hotel::Room.new(room_id: 1)
      expect(room.room_id).must_be_kind_of Integer
      expect(Hotel::Room.cost).must_be_kind_of Float
    end
  end

  describe "num_rooms" do
    it "contains 20 rooms" do
      expect(Hotel::Room.num_rooms).must_equal 20
    end
  end
end
