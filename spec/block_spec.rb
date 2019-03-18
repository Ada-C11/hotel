require_relative "spec_helper"

describe "Block" do
  before do
    @rooms = Hotel::Room.make_rooms([1, 2, 3, 4, 5])
    @block = Hotel::Block.new(rooms: @rooms, start_date: "2019-03-20", end_date: "2019-03-27", discount_rate: 175)
  end

  describe "Block instantiation" do
    it "is an instance of a Block" do
      expect(@block).must_be_kind_of Hotel::Block
    end

    it "raises an error if more than 5 rooms are given" do
      rooms = Hotel::Room.make_rooms([1, 2, 3, 4, 5, 6])

      expect { Hotel::Block.new(rooms: rooms, start_date: "2019-03-20", end_date: "2019-03-27", discount_rate: 175) }.must_raise ArgumentError
    end
  end

  describe "available_rooms?" do
    it "returns an array of 5 rooms immediately after block instantiation" do
      available_rooms = @block.available_rooms?
      expect(available_rooms).must_be_kind_of Array
      expect(available_rooms.length).must_equal 5
      expect(available_rooms.first).must_be_kind_of Hotel::Room
    end

    it "returns an array of the correct 4 rooms if one room is booked" do
      single_room = @rooms.first
      @block.book_room(single_room)
      available_rooms = @block.available_rooms?

      expect(available_rooms.length).must_equal 4
      expect(available_rooms).wont_include single_room
    end

    it "returns an empty array if all rooms are booked" do
      @rooms.each do |room|
        @block.book_room(room)
      end
      available_rooms = @block.available_rooms?

      expect(available_rooms).must_be_kind_of Array
      expect(available_rooms.length).must_equal 0
    end
  end

  describe "book room" do
    it "raises an error if the selected room is not a part of the block" do
      room_outside_of_block = Hotel::Room.new(6)

      expect { @block.book_room(room_outside_of_block) }.must_raise ArgumentError
    end

    it "raises an an error if the selected room is already booked" do
      single_room = @rooms.first
      @block.book_room(single_room)

      expect { @block.book_room(single_room) }.must_raise ArgumentError
    end
  end
end
