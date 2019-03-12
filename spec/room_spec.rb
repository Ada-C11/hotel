require_relative "spec_helper"

describe 'Room class' do
  describe 'Room instantiation' do

    it 'creates an instance of room' do
      room = Room.new(1)
      expect(room).must_be_kind_of Room
    end

    it "is set up for specific attributes and data types" do
      room = Room.new(1)
      expect(room.number).must_be_kind_of Integer
    end
  end
end