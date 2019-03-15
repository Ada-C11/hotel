require_relative "spec_helper"

describe "Block Class" do
    let(:block) {Hotel::Block.new(id: 1, block_reservations: [1,2,3])}

    it "is an instance of Block" do
        expect(block).must_be_kind_of Hotel::Block
    end
  
    it "checks whether a room is available" do
        expect(block.block_room_available?(1)).must_equal :available
    end

    it "lists all available rooms for a block" do
        expect(block.list_available_rooms).must_be_kind_of Hash
        expect(block.list_available_rooms.length).must_equal 3
    end

    it "lists available rooms for a block when one room is reserved" do
        block.reserve_block_room(1)
        expect(block.list_available_rooms).must_be_kind_of Hash
        expect(block.list_available_rooms.length).must_equal 2
    end

    it "shows that a room is unavailable when the status has been changed" do
        block.reserve_block_room(1)
        expect(block.block_reservations[1]).must_equal :unavailable
    end

end