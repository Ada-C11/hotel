require_relative "spec_helper"

describe "ReservationSystem class" do
  describe 'Rooms and bookings methods' do
    it "can find room by booking number" do
      booking = HotelBooking::Booking.new(
        reference_number: 20,
        room: 1,
        start_date: Date.parse('2001-02-03'),
        end_date: Date.parse('2001-02-07'),
        price: 200
        )

      ReservationSystem.add_booking(booking)
      room = ReservationSystem.find_room_by_number(20)
      expect(room.room).must_equal 1
    end

    it "can find booking by room number" do
      booking = HotelBooking::Booking.new(
        reference_number: 20,
        room: 1,
        start_date: Date.parse('2001-02-03'),
        end_date: Date.parse('2001-02-07'),
        price: 200
        )

      ReservationSystem.add_booking(booking)
      room = ReservationSystem.find_booking_by_number(1)
      expect(room.reference_number).must_equal 20
    end

    it "can find bookings by date" do
      booking = HotelBooking::Booking.new(
        reference_number: 20,
        room: 1,
        start_date: Date.parse('2001-02-03'),
        end_date: Date.parse('2001-02-07'),
        price: 200
        )

      ReservationSystem.add_booking(booking)
      room = ReservationSystem.find_booking_by_number(1)
      expect(room.reference_number).must_equal 20
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
