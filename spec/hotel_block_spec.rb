# require 'date'
# require_relative 'spec_helper'

# describe "Block class" do
#   before do
#     # @hotel = Booking::Hotel.new(5)
#     @checkin_date = Date.new(2019,1,4)
#     @checkout_date = Date.new(2019,1,7)

#     @block = Booking::Block.new(@checkin_date, @checkout_date, [1,3,4,5], 150)
#   end

  # it "creates a hotel_block" do
  # #  @block = @hotel.hotel_block(@checkin_date, @checkout_date, [1,3,4,5], 150)


  #  expect(@block).must_be_kind_of Array
  #  expect(@block.length).must_equal 4
  #  expect(@block[1]).must_be_kind_of Booking::Reservation
  # end

  # it "raises an error if at least one of the selected rooms is unavailable" do
  #   @hotel.add_reservation(@checkin_date, @checkout_date)
  #   expect{@hotel.hotel_block(@checkin_date, @checkout_date, [1,3,4,5], 150)}.must_raise ArgumentError
  # end
# end
