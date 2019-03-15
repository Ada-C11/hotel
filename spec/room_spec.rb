require_relative "spec_helper"

describe Room do
  describe "initialize" do
    it "must be an instance of the room" do
      room = Room.new(3)
      expect(room).must_be_kind_of Room
    end
  end
  # describe "add reservation method" do
  #   it "adds the date of each reservation to the room reservation array" do
  #   end
end
