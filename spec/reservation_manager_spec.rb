require_relative 'spec_helper.rb'
require 'date'

describe "Reservation Manager" do
  before do
    @frontdesk = Hotel::ReservationManager.new
  end

  it "should create an instance of the reservation Manager" do
    expect(@frontdesk).must_be_instance_of Hotel::ReservationManager
  end 


  it "displays all available rooms" do
    expect(@frontdesk.hotel_rooms).must_be_instance_of(Array)
    expect(@frontdesk.hotel_rooms.first).must_equal(1)
    expect(@frontdesk.hotel_rooms[3]).must_equal(4)
    expect(@frontdesk.hotel_rooms.length).must_equal(20)
  end

  describe "book reservation method" do
    before do
      @frontdesk = Hotel::ReservationManager
      @frontdesk.book_reservation(1, Date.new(2019,3,15), Date.new(2019,3,18))
      @frontdesk.book_reservation(1, Date.new(2019,4,10), Date.new(2019,3,12))
      @frontdesk.book_reservation(2, Date.new(2019,3,12), Date.new(2019,3,17))
    end

  end

#   describe "search reservation by date method" do 
#     before do 
#       @frontdesk = Hotel::ReservationManager.new(4)
#       @check_in = Date.new(2019,3,15)
#       @check_out = Date.new(2019,3,18)
#     end
     
#     it "allows you to check reservations by a specific date" do
#        @frontdesk.book_reservation(1, @check_in, @check_out)
#        check = @frontdesk.res_by_date(@check_in)
#        expect(check[0]).must_be_instance_of(Hotel::Reservation)
#     end
#  end  

#   describe "room availability method" do
#     before do
#       @frontdesk = Hotel::ReservationManager.new(3)
#       @check_in = Date.new(2019,3,15)
#       @check_out = Date.new(2019,3,18)
#       @reservation1 = @frontdesk.book_reservation(1, @check_in, @check_out)

#       @check_in2 = Date.new(2019,3,15)
#       @check_out2 = Date.new(2019,3,18)
#       @reservation2 = @frontdesk.book_reservation(2, @check_in2, @check_out2)
#     end

#     it "returns a list of rooms that are available" do
#       availability = @frontdesk.room_availability(@check_in, @check_out)
#       expect(availability).must_be_kind_of(Array)
#     end  

#     it "checks if booked room number is included in array available rooms " do 
#       availability = @frontdesk.room_availability(@check_in, @check_out)
#       expect(availability.length).must_equal 1
#       expect(availability).wont_include 2
#     end

#     it "cannot book a room twice" do
#       expect(@reservation1.room_number).wont_equal @reservation2.room_number
#     end

#     it "a reservation is allowed to start the same day another ends" do
#       @check_in5 = Date.new(2019,3,18)
#       @check_out5 = Date.new(2019,3,20)
#       @reservation5 = @frontdesk.book_reservation(@check_in5, @check_out5)
      
#       expect(@reservation5).must_be_kind_of(Hotel::Reservation)
#     end

#     it "raises an exception when there are no rooms for the given date" do
#       @check_in3 = Date.new(2019,3,15)
#       @check_out3 = Date.new(2019,3,18)
#       @reservation3 = @frontdesk.book_reservation(@check_in3, @check_out3)
#       @check_in4 = Date.new(2019,3,15)
#       @check_out4 = Date.new(2019,3,18)

#       expect{@frontdesk.room_availability(@check_in4, @check_out4)}.must_raise ArgumentError
#     end
 
   
#   end

# end


#   describe "find available block rooms method" do
#     before do
#       @frontdesk = Hotel::ReservationManager.new
#       @booked_range = Hotel::DateRange.new(Date.new(2019,3,15), (Date.new(2019,3,18)))
#       @block_res = @frontdesk.make_block([*1..5], @booked_range, @rate_type = "Discount")
#     end

#     it "returns available block rooms" do
#     end
#   end
end