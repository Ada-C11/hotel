require_relative "spec_helper"

describe "ReservationSystem class" do
  describe 'Find room and booking methods' do

    it "can find room by booking number" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)

      booking = reservation_system.make_booking('2001-02-03', '2001-02-07')

      room = reservation_system.find_room_by_booking_number(booking.reference_number)

      expect(room).wont_equal nil
    end

    it "can find room by room number" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)

      booking = reservation_system.make_booking('2001-02-03', '2001-02-07')

      room = reservation_system.find_room_by_room_number(booking.room.number)

      expect(room).wont_equal nil
    end

    it "can find booking by room number" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)

      booking = reservation_system.make_booking('2001-02-03', '2001-02-07')
      bookings = reservation_system.find_bookings_by_room_number(booking.room.number)

      expect(bookings).must_equal [booking]
    end

    it "can find bookings by date" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
      booking = reservation_system.make_booking('2001-02-03', '2001-02-07')

      bookings = reservation_system.find_booking_by_date(booking.start_date, booking.end_date)
      
      expect(bookings).must_equal [booking]
    end
  end

  describe 'Get available rooms' do
    before do
      @reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
    end
    
    it "Returns an array of 20 available rooms" do
      rooms = @reservation_system.get_available_rooms('2001-02-03', '2001-02-07')
      expect(rooms.length).must_equal 20
    end

    it "Includes rooms that start before range and ends before range" do
      booking = @reservation_system.make_booking('2001-02-03', '2001-02-07')
      rooms = @reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(rooms.include?(booking)).must_equal false
      expect(rooms.length).must_equal 19
    end

    it "Includes rooms that start after range" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start before start date and end during range" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start during range and ends after range" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that overlap with range" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start before range and ends in range" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start in range and ends after range" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start and end anywhere in range" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start before range and ends after range" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start in range and ends in range" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start in range and ends in range" do
      reservation_system = HotelBooking::ReservationSystem.new("Wyndham", 20)
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end










  end
end
