require_relative "reservation"
require_relative "room"
require_relative "hotel_block"

class Hotel
  attr_reader :name, :rooms, :reservations, :blocks

  def initialize
    @name = name
    @reservations = []
    @blocks = []
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

  def make_block(rooms, start_date, end_date)
    id = @blocks.length + 1
    a
    rooms.each do |room|
      if !load_available.include?(room)
        raise ArgumentError, "This room is booked for this date range and can't be in the block"
        rooms.delete(room)
      end
      block = Block.new(id, rooms, start_date, end_date)
      @blocks << block
      return block
    end
  end

  def reserved_rooms
    reserved = []
    @reservations.each do |reservation|
      reserved << reservation.room
    end
    #return @rooms - reserved_rooms.uniq
    return reserved
  end

  def load_availables(start_date, end_date)
    available_rooms = []
    all_available = []
    @reservations.each do |reservation|
      if start_date >= reservation.dates.last || end_date <= reservation.dates.first
        available_rooms << reservation.room
      end
    end
    #all_available = (available_rooms + free_rooms).uniq
    all_available = (available_rooms + (@rooms - reserved_rooms)).uniq
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
