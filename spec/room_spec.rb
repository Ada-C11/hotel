require_relative 'spec_helper'

describe "Room" do
  describe "#initialize" do
    it "Creates an instance of Room" do
      room = Hotel::Room.new(1, 300)
      expect(room).must_be_kind_of Hotel::Room
    end
  end

  describe "list_rooms" do
    before do
      @rooms = Hotel::Room.list_rooms(100, 20, 150)
    end
    it "Generates a collection of multiple rooms" do
      expect(@rooms).must_be_kind_of Array
      expect(@rooms.length).must_equal 20
    end

    it "Has the correct cost" do
      expect(@rooms.first[:cost]).must_equal 150
    end

    it "Has the correct ID for the first room" do
      expect(@rooms.first[:id]).must_equal 100
    end

    it "Has the correct ID for the last room" do
      expect(@rooms.last[:id]).must_equal 119
    end
  end
end