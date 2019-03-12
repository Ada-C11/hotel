require_relative "spec_helper"

describe 'Room class' do
  describe 'Room instantiation' do

    it 'creates an instance of room' do
      room = Room.new(number: 1, price: 200)
      expect(room).must_be_kind_of Room
    end

    it "is set up for specific attributes and data types" do
      room = Room.new(number: 1, price: 200)
      expect(room.number).must_be_kind_of Integer
      expect(room.price).must_equal 200
    end
  end
end