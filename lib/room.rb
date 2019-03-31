
module HotelSystem
  class Room
    attr_reader :id, :reservations, :price_per_night

    def initialize(id:, price_per_night: 200, reservations: [])
      @id = id
      @price_per_night = price_per_night
      @reservations = reservations
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def available?(date)
      reservations.each do |reservation|
        return false if reservation.date_range.include?(date)
      end
      return true
    end

    def self.create_rooms(room_numbers)
      rooms = room_numbers.map do |num|
        HotelSystem::Room.new(id: num)
      end
      return rooms
    end
  end
end
