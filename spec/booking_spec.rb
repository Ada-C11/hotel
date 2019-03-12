require_relative "spec_helper"
require 'date'

describe 'Booking class' do
  describe 'Booking instantiation' do
    before do
      @booking = Booking.new(
        room: Room.new(1),
        start_date: Date.parse('2001-02-03'),
        end_date: Date.parse('2001-02-07'),
        price: 200)
    end
    
    it 'creates an instance of a booking' do
      expect(@booking).must_be_kind_of Booking
    end

    it "is set up for specific attributes and data types" do
      expect(@booking.room).must_be_kind_of Room
      expect(@booking.start_date).must_be_kind_of Date
      expect(@booking.end_date).must_be_kind_of Date
      expect(@booking.price).must_equal 200
    end
  end

  describe 'booking duration' do
    before do
      @booking = Booking.new(
        room: Room.new(1),
        start_date: Date.parse('2001-02-03'),
        end_date: Date.parse('2001-02-07'),
        price: 200
      )
    end

    it "totals the duration of booking in days" do
      expect(@booking.booking_duration).must_equal 4
    end
end

  describe 'booking cost' do
    before do
      @booking = Booking.new(
        room: Room.new(1),
        start_date: Date.parse('2001-02-03'),
        end_date: Date.parse('2001-02-07'),
        price: 200
      )
    end

    it "given a booking, can calculate total cost" do
      expect(@booking.booking_cost).must_equal 800
    end
  end
end

