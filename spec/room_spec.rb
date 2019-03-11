require_relative 'spec_helper'

describe "Room" do
  describe "#initialize" do
    it "Creates an instance of Room" do
      room = Hotel::Room.new(1, 300)
      room.must_be_kind_of Hotel::Room
    end
  end
end