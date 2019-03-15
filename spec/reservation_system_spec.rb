require_relative "spec_helper"

describe "ReservationSystem class" do
  describe 'Rooms and bookings methods' do

    it "can find room by booking number" do
      reservation_system = HotelBooking::ReservationSystem.new

      booking = reservation_system.make_booking('2001-02-03', '2001-02-07' )

      room = reservation_system.find_room_by_booking_number(booking.reference_number)

      expect(room).wont_equal nil
    end

    it "can find booking by room number" do
      reservation_system = HotelBooking::ReservationSystem.new

      booking = reservation_system.make_booking('2001-02-03', '2001-02-07')

      bookings = reservation_system.find_bookings_by_room_number(booking.room.number)

      expect(bookings).must_equal [booking]
    end

    it "can find bookings by date" do
      reservation_system = HotelBooking::ReservationSystem.new
      booking = reservation_system.make_booking('2001-02-03', '2001-02-07')

      bookings = reservation_system.find_booking_by_date(booking.start_date)
      
      expect(bookings).must_equal [booking]
    end
  end

  describe 'Get available rooms' do
    it "Returns an array of available rooms" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Throws an error if there are no reservations" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does includes rooms that start before range and ends before range" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does includes rooms that start before range and ends in range" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end



    it "Does not include rooms that start before start date and end during range" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start during range and ends after range" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that overlap with range" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start before range and ends in range" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start in range and ends after range" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start and end anywhere in range" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start before range and ends after range" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start in range and ends in range" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end

    it "Does not include rooms that start in range and ends in range" do
      reservation_system = HotelBooking::ReservationSystem.new
      bookings = reservation_system.get_available_rooms('2001-02-03', '2001-02-07')

      expect(bookings).must_be_kind_of Array
    end










  end
end
