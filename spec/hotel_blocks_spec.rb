require "spec_helper"

describe "HotelBlocks class" do
  describe "HotelBlocks#initialize" do
    before do
      @hotel_block = HotelBlocks.new(start_date: "2019-3-19", end_date: "2019-3-23", rooms: [4, 5, 6], discounted_rate: 170)
    end
    it "is an instance of HotelBlocks" do
      expect(@hotel_block).must_be_kind_of HotelBlocks
    end
    it "raises an ArgumentError when user tries to create a hotel block with more than 5 rooms" do
      expect { @hotel_block = HotelBlocks.new(start_date: "2019-3-19", end_date: "2019-3-23", rooms: [4, 5, 6, 7, 8, 9], discounted_rate: 170) }.must_raise ArgumentError
    end
  end
end
