require_relative 'spec_helper'
require_relative '../lib/booking_central'

describe 'BookingCentral' do
  it 'initializes 20 rooms' do
    bookings = BookingCentral.new
    expect(bookings.rooms.length).must_equal 20
  end

  # it 'creates a new reservation' do
  #   skip
  #   new_booking = BookingCentral.reserve_room('04-01-2019', '04-02-2019')
  #   expect(bookings.include?(new_booking)).must_equal true
  # end
end