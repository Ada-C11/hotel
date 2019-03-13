require_relative "reservation"
require_relative "room"

class Hotel
  attr_reader :name, :rooms

  def initialize
    @name = name
    @reservations = []
    @rooms = []
    id = 1
    20.times do
      room = Room.new(id)
      @rooms << room
      id += 1
    end
  end

  def make_reservation(start_date, end_date)
    id = @reservations.length + 1
    room_id = @rooms.sample.id
    reservation = Reservation.new(id, room_id, start_date, end_date)
    @reservations.push(reservation)
    return reservation
  end

  def self.load_rooms
    return @rooms
  end

  def load_reservation(date)
    all_reservations = []
    @reservations.each do |reservation|
      if reservation.dates.include?(date)
        all_reservations.push(reservation)
      end
    end
    return all_reservations
  end
end
