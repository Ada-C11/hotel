require_relative "spec_helper"

describe "Room class" do
  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new(
        id: 1,
      )
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "default cost is $200" do
      expect(@room.cost).must_equal 200
    end

    it "sets reservations to an empty array if not provided" do
      expect(@room.reservations.length).must_equal 0
    end
  end
end
