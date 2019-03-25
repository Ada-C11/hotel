require_relative 'spec_helper.rb'

describe "Hotel Block" do
  before do
   @test_range = Hotel::DateRange.new(Date.new(2019,3,15), Date.new(2019,3,18))
  end

  describe "Create a Hotel Block" do
    it "should create an instance of the hotel block class" do
      expect(Hotel::HotelBlock.new([*1..5], @test_range)).must_be_instance_of(Hotel::HotelBlock)
    end 
 
    it "raises an argument error for booking more than 5 rooms" do
      expect{Hotel::HotelBlock.new([*1..6], @test_range)}.must_raise(ArgumentError)
    end
  end 

  describe "book block reservation method" do
    before do
      @hotel_block = Hotel::HotelBlock.new([*1..5], @test_range, 100)
    end

    it "returns a reservation with the right room number and dates" do
      reservation = @hotel_block.book_block_reservation(3, @test_range)
      expect(reservation.room).must_equal(3)
      expect(reservation).must_be_instance_of(Hotel::Reservation)
    end

    it "raises an argument error for room numbers that are incorrect" do
      expect{@hotel_block.book_block_reservation(7, @test_range)}.must_raise(ArgumentError)
    end
  end

  describe "block rooms available method" do
    before do
      @hotel_block = Hotel::HotelBlock.new([*1..5], @test_range, 100)
    end
    
    it "returns all currently available room blocks" do
      expect(@hotel_block.rooms_available).must_equal([1,2,3,4,5])
    end

    it "returns an array of all of the rooms that are available" do
      @hotel_block.book_block_reservation(3, @test_range)
      @hotel_block.book_block_reservation(4, @test_range)
      expect(@hotel_block.rooms_available).must_equal([1,2,5])
    end

    it "returns an empty array if all block rooms are booked" do
      [*1..5].each do |room|
        @hotel_block.book_block_reservation(room, @test_range)
      end
      expect(@hotel_block.rooms_available).must_equal([])
    end
  end
end
