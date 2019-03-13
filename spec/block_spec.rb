require_relative "spec_helper"

describe "Block class" do
  describe "initialize method" do
    before do
      @hotel = HotelSystem::Hotel.new
      @date_range = HotelSystem::DateRange.new("01 Feb 2020", "10 Feb 2020")
      @block = HotelSystem::Block.new(date_range: @date_range,
                                      rooms: @hotel.rooms[0...5],
                                      discount_rate: 180,
                                      group_name: "ComicCon")
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
    it "will raise an exception if block size is greater than 5 or less than 1" do
      expect {
        HotelSystem::Block.new(date_range: @date_range,
                               rooms: @hotel.rooms[0...7],
                               discount_rate: 180,
                               group_name: "ComicCon")
      }.must_raise BlockError

      expect {
        HotelSystem::Block.new(date_range: @date_range,
                               rooms: [],
                               discount_rate: 180,
                               group_name: "ComicCon")
      }.must_raise BlockError
    end
    it "will contain a date range " do
      expect(@block.date_range).must_be_instance_of HotelSystem::DateRange
    end
    it "will adjust the rates of each of its rooms" do
      @block.rooms.each do |room|
        expect(room.rate).must_equal(@block.discount_rate)
      end
    end
    it "will add the block to each room's collection of blocks" do
      @block.rooms.each do |room|
        expect(room.blocks.values).must_include(@block)
      end
    end
  end
end
