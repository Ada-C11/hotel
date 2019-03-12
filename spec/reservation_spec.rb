# require_relative "spec_helper"

# describe "Reservation" do
#   before do
#     @reservation = Hotel::Reservation.new(
#       reservation_id: 1,
#       date_range: Hotel::DateRange.new(),
#       room_id: 1,
#     )
#   end

#   it "is an instance of Reservation" do
#     expect(@reservation).must_be_instance_of Hotel::Reservation
#   end

#   it "reservation id is an integer" do
#     expect(@reservation.reservation_id).must_equal 1
#   end

#   it "sets reservations to an empty array if not provided" do
#     expect(@reservation.reservations).must_be_kind_of Array
#     expect(@reservation.reservations.length).must_equal 0
#   end
# end
