require_relative "spec_helper"

describe "ReservationSystem class" do
  describe 'Rooms and bookings methods' do

    it "can find room by booking number" do
      reservation_system = HotelBooking::ReservationSystem.new
      booking = reservation_system.make_booking('2001-02-03', '2001-02-07')

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

      bookings = reservation_system.find_booking_by_date('2001-02-03')
      
      expect(bookings).must_equal [booking]
    end
  end

  # describe 'Requesting trips method' do
  #   it "if requests a trip based on a given date" do
  #     hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 0)
  #     room = Room.new(1)

  #     hotel.add_room(room)
  #     expect(hotel.rooms.first).must_equal room
  #   end
  # end
end
