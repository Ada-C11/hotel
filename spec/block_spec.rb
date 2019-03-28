
require_relative "spec_helper"

describe "Block class " do
  let(:nights) { [Date.new(2001, 2, 3), Date.new(2001, 2, 4)] }
  let(:room1) { Hotel::Room.new(room_number: 1) }
  let(:room2) { Hotel::Room.new(room_number: 2) }
  let(:room_collection) { [room1, room2] }
  let(:id) { 20 }
  let(:room_rate) { 160 }
  let(:block) { Hotel::Block.new(nights: nights, room_collection: room_collection, room_rate: room_rate, id: id) }

  it "is able to instantiate" do
    expect(block).must_be_kind_of Hotel::Block
  end

  it "can check for available rooms" do
    expect(block.has_available_rooms?).must_equal true
  end

  it "can book rooms" do
    expect(block.book(room: room1))
    expect(block.has_available_rooms?).must_equal true
    expect(block.book(room: room2))
    expect(block.has_available_rooms?).must_equal false
  end
end
