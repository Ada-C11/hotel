require "spec_helper"

describe "Room class" do
  describe "Room#initialize" do
    before do
      @room = Room.new(room_id: 2)
    end
    it "is an instance of room" do
      expect(@room).must_be_kind_of Room
    end
  end
end
