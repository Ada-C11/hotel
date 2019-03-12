require_relative "spec_helper"

describe 'Room class' do
  describe 'Room instantiation' do

    it 'creates an instance of room' do
      room = HotelBooking::Room.new(1)
      expect(room).must_be_kind_of HotelBooking::Room
    end

    it "is set up for specific attributes and data types" do
      room = HotelBooking::Room.new(1)
      expect(room.number).must_be_kind_of Integer
    end
  end
end