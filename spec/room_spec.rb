require_relative "spec_helper"

describe "Room Class" do
  describe "Room initializer" do
    before do
      @room = Room.new(
        id: 1,
      )
    end
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Room
    end
  end
end
