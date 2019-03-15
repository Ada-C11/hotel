require_relative 'spec_helper'
require 'date'

describe 'Booking class' do
  before do
    @booking = HotelBooking::Booking.new(
      reference_number: 1,
      room: HotelBooking::Room.new(1),
      start_date: '2001-02-03',
      end_date: '2001-02-07',
      price: 200
      )
  end
  
  describe 'Booking instantiation' do
    it 'creates an instance of a booking' do
      expect(@booking).must_be_kind_of HotelBooking::Booking
    end

    it 'is set up for specific attributes and data types' do
      expect(@booking.room).must_be_kind_of HotelBooking::Room
      expect(@booking.start_date).must_be_kind_of String
      expect(@booking.end_date).must_be_kind_of String
      expect(@booking.price).must_equal 200
    end
  end

  describe 'booking duration' do
    it 'totals the duration of booking in days' do
      expect(@booking.booking_duration).must_equal 4
    end
  end

  describe 'booking cost' do
    it 'given a booking, can calculate total cost' do
      expect(@booking.booking_cost).must_equal 800
    end
  end

  describe 'overlap?' do
    it 'parse string into date object' do
      result = @booking.overlaps?('2001-02-03', '2001-02-07')
      expect(result).must_equal true
    end
  end
end
