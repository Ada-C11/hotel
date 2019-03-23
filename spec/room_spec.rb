require_relative "spec_helper"

describe "Room class" do
  room = Hotel::Room.new(1)
  it "creates a room" do
    expect(room).must_be_instance_of Hotel::Room
  end

describe 'initialize' do
    it 'is instance of Room' do
    room.must_be_kind_of Hotel::Room
    end
end

