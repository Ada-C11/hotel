require_relative "spec_helper"

describe "Room Class" do
  describe "Initialize" do
    it "Creates an instance of a Room" do
      expect(Room.new).must_be_kind_of Room
    end
  end
end
