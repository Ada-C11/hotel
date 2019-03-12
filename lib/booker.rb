require_relative "room"
require_relative "date_range"
require_relative "reservation"
# require_relative "block"

module Hotel
  class Booker
    attr_reader :rooms, :reservations

    def initialize
      @rooms = (1..20).map do |number|
        Hotel::Room.new(id: number)
      end
      @reservations = []
    end

    def add_reservation(reservation)
      @reservations.push(reservation)
    end

    def reserve(id:, date_range:, room: nil,
                room_id: nil, price: 200)
      reservation = Hotel::Reservation.new(id: id, date_range: date_range, room: room,
                                           room_id: room_id, price: price)
      add_reservation(reservation)
      return reservation
    end
  end
end
