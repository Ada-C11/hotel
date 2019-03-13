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
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)

      if start_date >= end_date
        raise ArgumentError, "Reservation must be at least one day long"
      end

      dates = generate_dates(start_date: start_date, end_date: end_date)

      reservation = Hotel::Reservation.new(dates: dates,
                                           room: assign_room(array_of_dates: dates))

      reservation.room.booked_dates.concat(dates)

      reservations << reservation

      return reservation
    end

    def find_by_date(date:)
      date = Date.parse(date)
      on_this_date = []

      reservations.select { |reservation| reservation.dates.include?(date) }
    end

    def find_by_room(room_number:)
      rooms.find { |room| room.number == room_number }
    end

    def open_rooms(date:)
      # open_rooms = rooms.reject do |room|
      #   room.booked_dates.include?(date)
      # end

      open = rooms.find_all { |room| room.available?(date: date) }
      p open
      # if open != true
      #   raise ArgumentError, "No rooms available"
      # end

      return open
    end

    private

    def rooms_array
      rooms = []
      NUMBER_OF_ROOMS.times { |i| rooms << Hotel::Room.new(room_number: i + 1) }
      return rooms
    end

    def generate_dates(start_date:, end_date:)
      dates = []
      night = start_date
      until night == end_date # not including end date
        dates << night
        night += 1 # go to the next day
      end
      return dates
    end

    def assign_room(array_of_dates:)
      assigned_room = nil
      rooms.each do |room|
        array_of_dates.each do |date|
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
