require_relative "spec_helper"

describe "RoomManager class" do
  describe "initialize" do
    it "can be instantiated" do
      expect(Hotel::RoomManager.new).must_be_instance_of Hotel::RoomManager
    end
  end
  describe "list_data method" do
    it "can list all the 20 rooms" do
      expect(Hotel::RoomManager.new.list_rooms.length).must_equal 20
    end
  end
end
