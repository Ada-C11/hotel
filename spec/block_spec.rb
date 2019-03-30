require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "Block subclass" do
  before do
    @rooms = [Hotel::Room.new(room_number: 1), Hotel::Room.new(room_number: 2), Hotel::Room.new(room_number: 3)]
    @check_in = Date.today.to_s
    @check_out = (Date.today + 2).to_s
    @block = Hotel::Block.new(check_in: @check_in, check_out: @check_out, rooms: @rooms, discounted_rate: 100.00)
  end

  it "creates an instance of Block" do
    expect(@block).must_be_kind_of Hotel::Block
  end

  it "stores an array inside of a Block" do
    expect(@block.rooms).must_be_kind_of Array
  end

  it "contains instances of Room inside of the rooms array" do
    expect(@block.rooms[0]).must_be_kind_of Hotel::Room
  end

  it "throws an ArgumentError if there are more than 5 Rooms" do
    rooms = [Hotel::Room.new(room_number: 1),
             Hotel::Room.new(room_number: 2),
             Hotel::Room.new(room_number: 3),
             Hotel::Room.new(room_number: 4),
             Hotel::Room.new(room_number: 5),
             Hotel::Room.new(room_number: 6)]
    check_in = Date.today.to_s
    check_out = (Date.today + 2).to_s
    expect { Hotel::Block.new(check_in: check_in, check_out: check_out, room: rooms, discounted_rate: 100.00) }.must_raise ArgumentError
  end
end
