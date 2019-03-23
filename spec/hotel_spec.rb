# STILL WORKING THROUGH...

require "minitest/autorun"
# require "rspec"

describe Hotel do 
    it "has rooms" do
        hotel = Hotel.new 
        # create a hotel, get the number of rooms in the hotel, make sure it's the right number 
        # (2).must_equal 3
        (hotel.rooms.length).must_equal 20
    end 
end


# include RSpec
# #it can reserve a room for a given date range
# Describe Reserved do
#     it "can reserve a room for a given date range" do
#         reserved = reserved.new
#         expect(reserved).must_equal "Room 2 is now reserved."
# #make up room and date range to test
# Describe Reservation do 
# #it can find & list a reservation by a specific date
#     it "can find a reservation by a specific date" do 
#         reservation = Reservation.new
#         expect(reservation).must_equal "Room 1 is Reserved 05/05/19"
#     end
# end
# Describe Available_Rooms do
# #it can find which rooms are available for a date range
# it "can find which rooms are available for a date" do 
#     expect(available_rooms).must_equal "Rooms 2 - 20 are available."
# end
# end
# USER STORIES 
# As a user of the hotel system...
# I can access the list of all of the rooms in the hotel
# I can reserve a room for a given date range, so that I can make a reservation
# I can access the list of reservations for a specific date, so that I can track reservations by date
# I can get the total cost for a given reservation
# I want exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range


