require 'spec_helper.rb'

# describe "Room class" do
#   describe "initialize" do
#     it "returns an instance of room object" do
#       ids = [3, 4, 5]
#       ids.each do |id|
#         expect(Room.new(id)).must_be_kind_of Room
#       end
#     end
#   end

#   describe "reserve method" do
#     before do
#       @room = Room.new(5)
#       @duration = Time_Interval.new("2019-08-10", "2019-08-16")
#     end

#     it "adds a new reservation object to the room's reservation list" do
#       num_reservations_before = @room.reservation_list.length
#       @room.reserve(@duration)
#       expect(@room.reservation_list.length).must_equal num_reservations_before + 1
#     end
#   end

#   describe "list_reservation method" do
#     before do
#       @room = Room.new(6)
#       @duration_one = Time_Interval.new("2019-08-10", "2019-08-16")
#       @duration_two = Time_Interval.new("2019-08-16", "2019-08-19")
#     end

#     it "returns a list of all reservations for one room on a specific date" do
#       @room.reserve(@duration_one)
#       @room.reserve(@duration_two)
#       list = @room.list_reservations("2019-08-10")
#       expect(list).must_be_instance_of Array
#     end
#   end
# end