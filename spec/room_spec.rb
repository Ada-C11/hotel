require_relative "spec_helper"

describe 'Room class' do
  describe 'Room instantiation' do
    before do
      @room = HotelBooking::Room.new(1)
    end

    it 'creates an instance of room' do
      expect(@room).must_be_kind_of HotelBooking::Room
    end

    it "is set up for specific attributes and data types" do
      expect(@room.number).must_be_kind_of Integer
    end
  end
end
