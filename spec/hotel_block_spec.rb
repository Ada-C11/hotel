require "spec_helper"

describe "HotelBlock class" do
  describe "HotelBlock#initialize" do
    let (:hotel_block) { HotelBlock.new(start_date: "2019-3-19", end_date: "2019-3-23", rooms: [4, 5, 6], discounted_rate: 170) }
    it "is an instance of HotelBlock" do
      expect(hotel_block).must_be_kind_of HotelBlock
    end
    it "raise argument error when the start_date is after end_date" do
      expect { HotelBlock.new(start_date: "2019-4-23", end_date: "2019-3-23", rooms: [4, 5, 6], discounted_rate: 170) }.must_raise ArgumentError
    end
    it "raises an ArgumentError when user tries to create a hotel block with more than 5 rooms" do
      expect { hotel_block = HotelBlock.new(start_date: "2019-3-19", end_date: "2019-3-23", rooms: [4, 5, 6, 7, 8, 9], discounted_rate: 170) }.must_raise ArgumentError
    end
  end
end
