require_relative 'spec_helper'

describe 'Hotel class' do
  describe 'initialize' do
    before do
      @hotel = HotelSystem::Hotel.new
    end

    it "is an instance of a Hotel" do
      expect(@hotel).must_be_kind_of HotelSystem::Hotel
    end

    it "establishes the base data structures when instantiated" do
      expect(@hotel.rooms).must_be_kind_of Array
      expect(@hotel.reservations).must_be_kind_of Array
    end

    it "lists all the possible rooms" do
      expect(@hotel.rooms).must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    end
  end
end