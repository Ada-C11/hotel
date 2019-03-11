require_relative "spec_helper"

describe 'Hotel class' do
  describe 'Hotel instantiation' do
    before do
      @hotel = Hotel.new("Wyndham")
      @rooms = []
    end

    it 'creates an instance of hotel' do
      expect(@hotel).must_be_kind_of Hotel
    end

    it "is set up for specific attributes and data types" do
      expect(@hotel.hotel_name).must_be_kind_of String
    end

    it "sets room to an empty array if not provided" do
      expect(@hotel.rooms).must_be_kind_of Array
      expect(@hotel.rooms.length).must_equal 0
    end
  end
end