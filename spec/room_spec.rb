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
end
