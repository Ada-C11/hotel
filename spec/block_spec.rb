require_relative 'spec_helper'

describe "Block class" do
  describe "Block instantiation" do
    before do
      rooms = []
      5.times do |i|
        rooms << Hotel::Room.new(
          room_num: i+1
        )
      end
      @block = Hotel::Block.new(
        start_date: "2016-08-08",
        end_date: "2016-08-15",
        rooms: rooms,
        discounted_rate: 150)
    end

    it "is an instance of Block" do
      expect(@block).must_be_kind_of Hotel::Block
    end

    it "returns block discounted rate" do
      expect(@block.rooms[0].room_rate).must_equal 150
      expect(@block.rooms[1].room_rate).must_equal 150
    end

    it "raises an ArgumentError" do
        rooms = []
        6.times do |i|
        rooms << Hotel::Room.new(
          room_num: i+1)
        end
        expect do
        @block = Hotel::Block.new(
          start_date: "2016-08-08",
          end_date: "2016-08-15",
          rooms: rooms,
          discounted_rate: 150)
        end.must_raise ArgumentError
    end
  end
end