require_relative 'spec_helper.rb'

describe "Hotel Block" do
  before do
   @test_range = Hotel::DateRange.new(Date.new(2019,3,15), Date.new(2019,3,18))
  end

  describe "Create a Hotel Block" do
    it "should create an instance of the hotel block class" do
      expect(Hotel::HotelBlock.new([*1..5], @test_range)).must_be_instance_of(Hotel::HotelBlock)
    end 
 
  #   it "raises an argument error for booking more than 5 rooms" do
  #     expect{Hotel::HotelBlock.new([*1..6], @check_in, @check_out, 100)}.must_raise(ArgumentError)
  #   end
  end 

  # describe "add reservation method" do
  #   before do
  #     @hotelblock = Hotel::HotelBlock.new([*1..5], @check_in, @check_out )
  #   end

  #   it "returns an instance of reservation with a room #" do
  #     reservation = @hotelblock.add_reservation(1, @check_in, @check_out, 100)
  #     expect(reservation).must_be_instance_of(Hotel::Reservation)
  #     expect(reservation.room_number).must_equal(1)
  #   end

  #   it "raises an argument error if date range is invalid" do
  #     expect{@hotelblock.add_reservation(5, Date.new(2019,3,15), Date.new(2019,3,17))}.must_raise(ArgumentError)
  #     expect{@hotelblock.add_reservation(5, Date.new(2019,3,15), Date.new(2019,3,18))}.must_raise(ArgumentError)
  #   end

  # end

  # describe "room available method" do
  #   before do
  #     @hotelblock = Hotel::HotelBlock.new([*1..5], Date.new(2019,3,15), Date.new(2019,3,18))
  #   end

  #   it "all block rooms return if they are all available" do
  #     expect(@hotelblock.rooms_available).must_equal([1, 2, 3, 4, 5])
  #   end

  #   it "returns an empty array if there are no available block rooms" do
  #     [*1..5].each do |r|
  #       @hotelblock.add_reservation(r, @check_in, @check_out, 100)
  #     end

  #     expect(@hotelblock.rooms_available).must_equal([])
  #   end

  #   it "returns an array of block rooms that are available" do
  #     @hotelblock.add_reservation(3, @check_in, @check_out, 100)
  #     expect(@hotelblock.rooms_available).must_equal([1, 2, 4, 5])
  #     @hotelblock.add_reservation(2, @check_in, @check_out, 100)
  #     expect(@hotelblock.rooms_available).must_equal([1, 4, 5])
  #   end

  # end 

  # describe "make block reservation method" do
  #   before do
  #     @check_in = Date.new(2019,3,15)
  #     @check_out = Date.new(2019,3,18)
  #     @frontdesk = Hotel::HotelBlock.new([*1..5], @check_in, @check_out)

  #     @block_res = @frontdesk.make_block([*1..5], @check_in, @check_out)
  #   end

  #   it "returns an instance of a block" do
  #     expect(@block_res).must_be_instance_of(Hotel::HotelBlock)
  #   end

  #   it "adds the booked block to the block reservation array" do
  #     starter_block_res = @frontdesk.reservations.length
  #     @frontdesk.make_block([*1..5], @check_in, @check_out, 100)
  #     expect(@frontdesk.reservations.length - starter_block_res).must_equal(1)
  #   end

  #   it "will raise an error if reservation you are booking is in a block" do
  #       @frontdesk.make_block([2, 3], @check_in, @check_out)
  #       expect{@frontdesk.add_reservation(2, @check_in, @check_out)}.must_raise ArgumentError
  #   end

  # end

  # describe "book block method" do
  #   it "returns a reservation" do
  #     @frontdesk = Hotel::HotelBlock.new([*1..5], @check_in, @check_out)
  #     block_res = @frontdesk.book_block(3, @check_in, @check_out)
  #     expect(block_res).must_be_instance_of(Hotel::Reservation)
  #   end
  # end

end
