require_relative "reservation"
require_relative "room"

class Hotel
  attr_reader :name, :rooms, :reservations

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
    # raise ArgumentEror if the available rooms is empty
    room = load_availables(start_date, end_date).sample
    reservation = Reservation.new(id, room, start_date, end_date)
    @reservations.push(reservation)
    room.reservations.push(reservation)
    return reservation
  end

  def free_rooms
    reserved_rooms = []
    @reservations.each do |reservation|
      reserved_rooms << reservation.room
    end
    return @rooms - reserved_rooms.uniq
  end

  def load_availables(start_date, end_date)
    available_rooms = []
    all_available = []
    @reservations.each do |reservation|
      if start_date >= reservation.dates.last || end_date <= reservation.dates.first
        available_rooms << reservation.room
      end
    end
    all_available = (available_rooms + free_rooms).uniq
    return all_available
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
