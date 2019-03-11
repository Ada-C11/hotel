require_relative "spec_helper"

describe "Hotel_manager class" do
  before do
    @hotel_manager = Hotel::Hotel_manager.new
  end

  describe "Hotel_manager instantiation" do
    it "is an istanceof a Hotel_manager" do
      expect(@hotel_manager).must_be_kind_of Hotel::Hotel_manager
    end

    it "has an array of 20 rooms" do
      expect(@hotel_manager.rooms.length).must_equal 20
    end
  end
end
