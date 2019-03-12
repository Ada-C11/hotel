require_relative "spec_helper"

describe "Block class" do
  describe "initialize method" do
    before do
      @hotel = HotelSystem::Hotel.new
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "10 Feb 2020")
      @block = HotelSystem::Block.new(date_range: @date_range,
                                      rooms: @hotel.rooms[0...5],
                                      discount_rate: 180)
    end
    it "will create an instance of block" do
      expect(@block).must_be_instance_of HotelSystem::Block
    end
    it "will contain an array of rooms" do
      expect(@block.rooms).must_be_instance_of Array
      @block.rooms.each do |room|
        expect(room).must_be_instance_of HotelSystem::Room
      end
    end
    it "will contain a date range " do
      expect(@block.date_range).must_be_instance_of HotelSystem::DateRange
    end
    it "will adjust the rates of each of its rooms" do
      @block.rooms.each do |room|
        expect(room.rate).must_equal(@block.discount_rate)
      end
    end
    it "will add the block to each room's list of blocks" do
      @block.rooms.each do |room|
        expect(room.blocks).must_include(@block)
      end
    end
  end
end
