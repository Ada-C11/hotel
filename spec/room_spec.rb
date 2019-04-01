require_relative "spec_helper"

describe "Room class" do
  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new(1)
    end

    it "is an instance of a Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end
  end

  describe "make rooms standard method" do
    it "has an array of 20 rooms" do
      rooms = Hotel::Room.make_rooms_standard

      expect(rooms).must_be_kind_of Array
      expect(rooms.first).must_be_kind_of Hotel::Room
      expect(rooms.length).must_equal 20
      expect(rooms.first.room_number).must_equal 1
      expect(rooms.last.room_number).must_equal 20
    end
  end

  describe "make rooms method" do
    it "has will produce an array with specified number of rooms" do
      rooms = Hotel::Room.make_rooms([1, 2, 3, 4, 5])

      expect(rooms).must_be_kind_of Array
      expect(rooms.first).must_be_kind_of Hotel::Room
      expect(rooms.length).must_equal 5
      expect(rooms.first.room_number).must_equal 1
      expect(rooms.last.room_number).must_equal 5
    end
  end
end
