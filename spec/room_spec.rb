require_relative "spec_helper"

describe "Room" do
  describe "initialize" do
    it "can be instantiated" do
      expect(Hotel::Room.new(1)).must_be_instance_of Hotel::Room
    end
  end
end
