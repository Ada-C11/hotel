require_relative "reservation"

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
    id = Hotels.reservations.length + 1
    room_id = Hotel.rooms.sample.to_s
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    reservation = Reservation.new(id, room_id, start_date, end_date)
    @reservations << reservation
  end

  def self.load_rooms
    return @rooms
  end
end
