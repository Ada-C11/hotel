require "spec_helper"

describe "Block class" do
  describe "initialize method" do
    before do
      @hotel = HotelSystem::Hotel.new
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "10 Feb 2020")
      @block = HotelSystem::Block.new(date_range: @date_range,
                                      rooms: @hotel.rooms[1...5],
                                      discount_rate: 180)
    end
    it "will create an instance of block" do
      expect(@block).must_be_instance_of HotelSystem::Block
    end
  end
end
