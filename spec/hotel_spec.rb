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
    end

    it "sets room to an empty array if not provided" do
      hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 0)
      expect(hotel.rooms).must_be_kind_of Array
      expect(hotel.rooms.length).must_equal 0
    end
  end

  # Add test to make sure you are not duplicating new rooms
  describe 'add rooms' do

    it "stores and instance of room" do
      hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 0)
      room = Room.new(1)

      hotel.add_room(room)

      expect(hotel.rooms.first).must_equal room
    end
  end

  describe 'find room' do

    it "can find room by number" do
      hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 20)

      room = hotel.find_room_by_number(5)

      expect(room.number).must_equal 5
    end
  end
end