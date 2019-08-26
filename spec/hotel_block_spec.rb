require_relative "spec_helper"
describe "Block" do
  describe "initialize" do
    before do
      room_rate = 100
      rooms = 1, 2, 3, 4, 5
      start_date = Date.new(2018, 5, 5)
      end_date = start_date + 5
      @block = Block.new(rooms, start_date, end_date, room_rate)
      @block.reserve_room
    end
    it "can creat a block of rooms for a specific date range" do
      expect(@block).must_be_instance_of Block
    end

  end
  describe "has room method" do
    before do
      room_rate = 100
      rooms = [1, 2, 3, 4, 5]
      start_date = Date.new(2018, 5, 5)
      end_date = start_date + 5
      @block = Block.new(rooms, start_date, end_date, room_rate)
      @block.reserve_room
      @block.reserve_room
      @block.reserve_room
    end
    it "return true if there are rooms available in the block" do
      expect(@block.reserve_room).must_be_kind_of Integer
      expect(@block.has_rooms?).must_equal true
     #expect(@block.reserve_room).must_respond_to NoRoomError
      @block.reserve_room
      expect(@block.has_rooms?).must_equal false
    end
  end
end
