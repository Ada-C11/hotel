
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

    ##### NEEDS TESTS

    def available?(date)
      reservations.each do |reservation|
        if date >= reservation.arrive_day && date < reservation.depart_day
          return false
        end
        # reservation.date_range.each do |reserved_date|
        #   return false if reserved_date.to_s == date.to_s
        # end
      end
      return true
    end

    def self.create_rooms(room_numbers)
      rooms = []
      room_numbers.each do |num|
        new_room = HotelSystem::Room.new(id: num)
        rooms << new_room
      end
      return rooms
    end
  end
end
