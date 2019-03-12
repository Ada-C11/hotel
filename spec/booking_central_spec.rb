require_relative 'spec_helper'
require_relative '../lib/booking_central'

describe 'BookingCentral' do
  it 'initializes 20 rooms' do
    bookings = BookingCentral.new
    expect(bookings.rooms.length).must_equal 20
  end

  it 'creates a new reservation' do
    bookings = BookingCentral.new
    new_booking = bookings.reserve_room(check_in: '04-01-2019', check_out: '04-02-2019')
    puts bookings.all_reservations
    expect(bookings.all_reservations.include?(new_booking)).must_equal true
  end
end