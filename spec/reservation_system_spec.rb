require_relative "spec_helper"

describe "ReservationSystem class" do
  describe 'Find room and booking methods' do
    before do
      @reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
    end

    it 'Can find room by booking number' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      room = @reservation_system.find_room_by_booking_number(booking.reference_number)
      expect(room).wont_equal nil
    end

    it 'Can find room by room number' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      room = @reservation_system.find_room_by_room_number(booking.room.number)
      expect(room).wont_equal nil
    end

    it 'Can find booking by room number' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      bookings = @reservation_system.find_bookings_by_room_number(booking.room.number)
      expect(bookings).must_equal [booking]
    end

    it 'Can find bookings by date' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      bookings = @reservation_system.find_booking_by_date(booking.start_date, booking.end_date)
      expect(bookings).must_equal [booking]
    end
  end

  describe 'Get available rooms' do
    before do
      @reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
    end

    it 'Returns an array of 20 available rooms' do
      rooms = @reservation_system.get_available_rooms('2001-02-03', '2001-02-07')
      expect(rooms.length).must_equal 20
    end

    it 'Includes rooms that start and ends before range' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      rooms = @reservation_system.get_available_rooms('2001-02-01', '2001-02-02')

      expect(rooms.include?(booking.room)).must_equal true
      expect(rooms.length).must_equal 20
    end

    it 'Includes rooms that start after range' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      rooms = @reservation_system.get_available_rooms('2001-02-09', '2001-02-11')

      expect(rooms.include?(booking.room)).must_equal true
      expect(rooms.length).must_equal 20
    end

    it 'Wont include rooms that start at start date and ends in range' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      rooms = @reservation_system.get_available_rooms('2001-02-03', '2001-02-06')

      expect(rooms.include?(booking.room)).must_equal false
      expect(rooms.length).must_equal 19
    end

    it 'Wont include rooms that start before before start date and ends in range' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      rooms = @reservation_system.get_available_rooms('2001-02-02', '2001-02-06')

      expect(rooms.include?(booking.room)).must_equal false
      expect(rooms.length).must_equal 19
    end

    it 'Wont include rooms that start during range and ends after range' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      rooms = @reservation_system.get_available_rooms('2001-02-04', '2001-02-09')

      expect(rooms.include?(booking.room)).must_equal false
      expect(rooms.length).must_equal 19
    end

    it 'Wont include rooms that start during range and during range' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      rooms = @reservation_system.get_available_rooms('2001-02-04', '2001-02-06')

      expect(rooms.include?(booking.room)).must_equal false
      expect(rooms.length).must_equal 19
    end

    it 'Wont include rooms that overlap with exact range' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      rooms = @reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(rooms.include?(booking.room)).must_equal false
      expect(rooms.length).must_equal 19
    end

    it 'Wont include rooms that start before range and ends after range' do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      rooms = @reservation_system.get_available_rooms('2001-02-02', '2001-02-09')

      expect(rooms.include?(booking.room)).must_equal false
      expect(rooms.length).must_equal 19
    end
  end

  describe 'available?' do
    before do
      @reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
    end

    it 'Returns true if room is available for date range' do
      booking = @reservation_system.make_booking('2001-02-02', '2001-02-09')
      rooms = @reservation_system.get_available_rooms('2001-02-02', '2001-02-09')

      expect(rooms.include?(booking.room)).must_equal false
    end
  end

  describe 'Make booking?' do
    before do
      @reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
    end

    it 'Returns an array of 20 available rooms' do
      rooms = @reservation_system.get_available_rooms('2001-02-03', '2001-02-07')
      expect(rooms.length).must_equal 20
    end

    it 'Raise argument for invalid date range' do
      expect{
        @reservation_system.make_booking('2001-02-09', '2001-02-02')
      }.must_raise ArgumentError
    end

    it 'Raise argument if invalid room is provided' do
      expect{
        @reservation_system.make_booking('2001-02-02', '2001-02-09', 50)
      }.must_raise ArgumentError
    end

    it 'Uses room to make booking when provided' do
      booking = @reservation_system.make_booking('2001-02-02', '2001-02-09', 5)
      expect(booking.room.number).must_equal 5
    end
  end
end
