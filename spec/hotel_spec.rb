require_relative "spec_helper"

describe 'Hotel class' do
  describe 'Hotel instantiation' do
    it 'creates an instance of hotel' do
      hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 20)
      expect(hotel).must_be_kind_of Hotel
    end

    it "is set up for specific attributes and data types" do
      hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 20)
      expect(hotel.hotel_name).must_be_kind_of String
      expect(hotel.number_of_rooms).must_be_kind_of Integer
      expect(hotel.rooms).must_be_kind_of Array
      expect(hotel.bookings).must_be_kind_of Array
    end

    it "sets rooms to an empty array if not provided" do
      hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 0)
      expect(hotel.rooms).must_be_kind_of Array
      expect(hotel.rooms.length).must_equal 0
    end

    it "sets bookings to an empty array if not provided" do
      hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 0)
      expect(hotel.bookings).must_be_kind_of Array
      expect(hotel.bookings.length).must_equal 0
    end
  end

  describe 'Rooms and bookings methods' do
    it "stores and instance of a room" do
      hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 0)
      room = Room.new(1)

      hotel.add_room(room)
      expect(hotel.rooms.first).must_equal room
    end

    it "stores and instance of a booking" do
      hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 0)
      booking = Booking.new(
        reference_number: 1,
        room: 1,
        start_date: Date.parse('2001-02-03'),
        end_date: Date.parse('2001-02-07'),
        price: 200
        )

      hotel.add_booking(booking)
      expect(hotel.bookings.first).must_equal booking
    end

    it "can find room by booking number" do
      hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 0)
      booking = Booking.new(
        reference_number: 20,
        room: 1,
        start_date: Date.parse('2001-02-03'),
        end_date: Date.parse('2001-02-07'),
        price: 200
        )

      hotel.add_booking(booking)
      room = hotel.find_room_by_number(20)
      expect(room.room).must_equal 1
    end

    it "can find booking by room number" do
      hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 0)
      booking = Booking.new(
        reference_number: 20,
        room: 1,
        start_date: Date.parse('2001-02-03'),
        end_date: Date.parse('2001-02-07'),
        price: 200
        )

      hotel.add_booking(booking)
      room = hotel.find_booking_by_number(1)
      expect(room.reference_number).must_equal 20
    end
  end
end