require "date"

require_relative "room"
require_relative "reservation"

module Hotel
  class FrontDesk
    NUMBER_OF_ROOMS = 20

    attr_reader :rooms, :reservations

    def initialize
      @reservations = []

      @rooms = rooms_array
    end

    def reserve(start_date:, end_date:)
      nights = generate_nights(start_date: start_date, end_date: end_date)

      reservation = Hotel::Reservation.new(nights: nights,
                                           room: assign_room(array_of_nights: nights))

      reservation.room.booked_nights.concat(nights)

      reservations << reservation

      return reservation
    end

    def find_reservations_by_date(date:)
      date = Date.parse(date)
      on_this_date = []

      reservations.select { |reservation| reservation.nights.include?(date) }
    end

    def find_room_by_number(room_number:)
      found_room = rooms.find { |room| room.number == room_number }
      raise ArgumentError, "That room doesn't exist" unless found_room
      return found_room
    end

    def open_rooms(start_date:, end_date:)
      nights = generate_nights(start_date: start_date, end_date: end_date)

      avail_rooms = []
      rooms.each do |room|
        nights.each do |date|
          if room.available?(date: date)
            avail_rooms << room
          end
        end
      end

      raise ArgumentError, "No rooms available" if avail_rooms == []

      return avail_rooms
    end

    private

    def rooms_array
      rooms = []
      NUMBER_OF_ROOMS.times { |i| rooms << Hotel::Room.new(room_number: i + 1) }
      return rooms
    end

    def generate_nights(start_date:, end_date:)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      if start_date >= end_date
        raise ArgumentError, "Reservation must be at least one day long"
      end
      nights = []
      night = start_date
      until night == end_date # not including end date
        nights << night
        night += 1 # go to the next day
      end
      return nights
    end

    def assign_room(array_of_nights:)
      assigned_room = nil
      rooms.each do |room|
        array_of_nights.each do |date|
          if room.available?(date: date)
            assigned_room = room
            break
          end
        end
        break if assigned_room
      end
      raise ArgumentError, "No available rooms for that date range" if assigned_room == nil
      return assigned_room
    end
  end
end
