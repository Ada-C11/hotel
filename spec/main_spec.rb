# require_relative "spec_helper"
# require "date"
# require "time"

# describe "Class Main" do
#   describe "add_reservations method" do
#     before do
#       @reservation_1 = Hotel::Reservation.new(
#         booking_ref: 1,
#         room_number: 1,
#         start_date: Date.today,
#         end_date: Date.today + 3,
#         total_cost: @total_cost,
#       )
#       @reservation_2 = Hotel::Reservation.new(
#         booking_ref: 1,
#         room_number: 1,
#         start_date: Date.today,
#         end_date: Date.today + 3,
#         total_cost: @total_cost,
#       )
#       @reservation_3 = Hotel::Reservation.new(
#         booking_ref: 1,
#         room_number: 1,
#         start_date: Date.today,
#         end_date: Date.today + 3,
#         total_cost: @total_cost,
#       )
#       @reservation_4 = Hotel::Reservation.new(
#         booking_ref: 1,
#         room_number: 1,
#         start_date: Date.today,
#         end_date: Date.today + 3,
#         total_cost: @total_cost,
#       )
#     end
#     it "@reservations array has a new reservation inside it" do
#       puts "HOTEL"
#       # puts reservations.length
#       Hotel::Main.add_reservation(@reservation_1)
#       Hotel::Main.add_reservation(@reservation_2)
#       Hotel::Main.add_reservation(@reservation_3)
#       Hotel::Main.add_reservation(@reservation_4)
#       puts Hotel::Main.reservations.length
#       expect(Hotel::Main.reservations.length).must_equal 4
#     end
#   end

#   it "is an Array" do
#     # @instance_of_main = Hotel::Main.new
#     # puts @instance_of_main
#     # puts "HELLO"
#     # puts "#{$all_rooms}"
#     expect(Hotel::Main.all_rooms).must_be_kind_of Array
#   end

#   it "can get reservations by start_date" do
#     puts "START_DATE"
#     puts Hotel::Main.reservations.length
#     puts Hotel::Main.get_reservation_by_date(Date.today)

#     expect(Hotel::Main.reservations[0].start_date).must_equal Date.today
#   end
# end
