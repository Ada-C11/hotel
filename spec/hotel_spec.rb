require 'simplecov'
SimpleCov.start
require_relative 'spec_helper'

describe 'Hotel class' do
  before do
    @hotel = HotelBooking::Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 20)
  end

  describe 'Hotel instantiation' do
    it 'creates an instance of hotel' do
      expect(@hotel).must_be_kind_of HotelBooking::Hotel
    end

    it 'is set up for specific attributes and data types' do
      expect(@hotel.hotel_name).must_be_kind_of String
      expect(@hotel.number_of_rooms).must_be_kind_of Integer
      expect(@hotel.rooms).must_be_kind_of Array
      expect(@hotel.bookings).must_be_kind_of Array
    end

    it 'sets rooms to an empty array if not provided' do
      hotel = HotelBooking::Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 0)
      expect(hotel.rooms).must_be_kind_of Array
      expect(hotel.rooms.length).must_equal 0
    end

    it 'sets bookings to an empty array upon instantiation' do
      expect(@hotel.bookings).must_be_kind_of Array
      expect(@hotel.bookings.length).must_equal 0
    end

    it 'stores an instance of a room' do
      hotel = HotelBooking::Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 0)
      room = HotelBooking::Room.new(0)

      hotel.add_room(room)
      expect(hotel.rooms.first).must_equal room
    end

    it 'stores an instance of a booking' do
      booking = HotelBooking::Booking.new(
        reference_number: 1,
        room: 1,
        start_date: Date.parse('2001-02-03'),
        end_date: Date.parse('2001-02-07'),
        price: 200
        )

        @hotel.add_booking(booking)
      expect(@hotel.bookings.first).must_equal booking
    end

  end
end