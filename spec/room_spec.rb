require_relative "spec_helper"

describe "Class named Room" do
  describe "Initialize" do
    before do
      @room = Hotel::Room.new(
        room_number: 1,
      )
    end
    it "creates an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end
  end
end
