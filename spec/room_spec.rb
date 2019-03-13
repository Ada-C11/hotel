require_relative "spec_helper"

describe "Room class" do
  before do
    @room = Hotel::Room.new(2)
  end

  describe "Instantiation of Room" do
    it "is an instance of Room class" do
      expect(@room).must_be_instance_of Hotel::Room
    end

    #   it "returns an Integer for room_number" do
    #     expect(@room.room_number).must_be_kind_of Integer
    #   end
    # end

    # describe "Availability of Room" do
    #   it "must take a date as a parameter" do
    #     expect(@room.availability("02-01-2000")).must_equal Date.parse
    #   end
  end
end
