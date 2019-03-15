require_relative 'spec_helper'
require_relative '../lib/booking_central'

describe 'BookingCentral' do
  it 'initializes 20 rooms' do
    bookings = BookingCentral.new

    expect(bookings.rooms.length).must_equal 20
  end

  it 'assigns a vacant room' do
    bookings = BookingCentral.new
    new_booking = bookings.reserve_room(check_in: '2019-01-03', check_out: '2019-01-04', room: 1)

    expect{(new_booking = bookings.reserve_room(check_in: '2019-01-03', check_out: '2019-01-04', room: assign_room(check_in, check_out)).room)}.wont_equal 1
  end

  it 'creates a new reservation' do
    bookings = BookingCentral.new
    new_booking = bookings.reserve_room(check_in: '2019-01-01', check_out: '2019-01-02', room: 1)

    expect(bookings.all_reservations.include?(new_booking)).must_equal true
  end

  it 'updates array of reservations' do
    bookings = BookingCentral.new
    new_booking = bookings.reserve_room(check_in: '2019-01-03', check_out: '2019-01-04', room: 1)
    new_booking2 = bookings.reserve_room(check_in: '2019-01-03', check_out: '2019-01-06', room: 2)
    new_booking3 = bookings.reserve_room(check_in: '2019-01-07', check_out: '2019-01-08', room: 3)
    
    expect(bookings.all_reservations.length).must_equal 3
  end

  it 'shows reservations by date' do
    bookings = BookingCentral.new
    new_booking = bookings.reserve_room(check_in: '2019-01-03', check_out: '2019-01-04', room: 1)
    new_booking2 = bookings.reserve_room(check_in: '2019-01-03', check_out: '2019-01-06', room: 10)
    new_booking3 = bookings.reserve_room(check_in: '2019-01-03', check_out: '2019-01-08', room: 20)

    expect((bookings.reservations_by_date('2019-01-03', '2019-01-04')).length).must_equal 3
  end

  it 'returns available rooms for given date range' do
    bookings = BookingCentral.new
    new_booking = bookings.reserve_room(check_in: '2019-01-03', check_out: '2019-01-06', room: 1)
  
    expect((bookings.list_available_rooms('2019-01-03', '2019-01-14')).count).must_equal 19
  end

  it 'rejects overbooking' do
    booker = BookingCentral.new
    expect{21.times{booker.reserve_room(check_in: '2019-01-03', check_out: '2019-01-06', room: 1 )}}.must_raise ArgumentError
      
  end
end