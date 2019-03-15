require_relative 'spec_helper'
# TODO: EVERYTHING OH THE HUMANITY FIX IT KAAAAATE WHAT HAVE YOU DONE!?
# TODO: DISASTERS!
# TODO: THE HOTEL IS ON FIRE?
# TripAdvisor Rating: 0.000001 star
# There are sharks in the pool.
# Rm. 16 smells like burnt hair
describe "Registry class" do
  describe "initialize" do
    before do
      test_registry = Registry.new
    end

    it "is an instance of registry" do
      expect(@test_registry).must_be_kind_of Hotel::Registry
    end

    it "Has a reservations array" do
      expect(@test_registry.rooms).must_be_kind_of Array
    end

  describe "reserve_room" do

    it "reservations array contains all bookings" do
      Reservation.new()
      expect(@test_registry.reservations.size).must_equal 2
    end

    it 'returns empty array if no reservations during date' do
      expect(@test_registry.find_by_date(Date.parse("1066.10.14"))).must_equal []
    end

    it "contains the correct object types"
    @test_registry.reservations.each do |reservation|
      expect(reservation).must_be_instance_of(Hotel::Reservation)
    end
  end
end

# describe 'reservations_during_date method' do
#   before do

#     @list_of_reservations = @hotel.reservations_during_date(Date.new(2018,7,5))
#   end
#    it 'returns array of reservations' do

#      expect( @list_of_reservations ).must_be_instance_of(Array)

#   end

#    it 'returns correct number of reservations' do
#     expect( @list_of_reservations.length ).must_equal(2)
#   end

#  end

#  describe 'available_rooms method' do

#    it 'returns empty array if no rooms available' do

#      [*1..20].each do |room|
#       @hotel.book_reservation(room, Date.new(2018,6,4), Date.new(2018,7,7))
#     end

#      expect(
#       @hotel.available_rooms(Date.new(2018,6,4), Date.new(2018,7,7))
#     ).must_equal([])
#     expect(
#       @hotel.available_rooms(Date.new(2018,6,1), Date.new(2018,6,5))
#     ).must_equal([])
#     expect(
#       @hotel.available_rooms(Date.new(2018,7,1), Date.new(2018,7,15))
#     ).must_equal([])

# ******************************************************** #
# *************TODO: TESTS I HAVEN'T WRITTEN************** #
# ******************************************************** #
# def find_by_date(date)
#   date = Date.parse(date)
#   by_date = @reservations.select do |entry|
#     entry.date.find_in_range(date)
#   end
#   by_date
# end

# def find_in_range(given_span)
#   in_range = @reservations.select do |entry|
#     entry.span.overlaps?(given_span)
#   end
#   in_range
# end
