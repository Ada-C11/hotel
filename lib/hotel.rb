require_relative "reservation"
require_relative "room"
require_relative "hotel_block"

class Hotel
  class AlreadyReservedError < StandardError; end

  attr_reader :rooms, :reservations, :room_rate

  def initialize
    @name = name
    @reservations = []
    @blocks = []
    @rooms = (1..20).to_a
    @room_rate = 200
 
  end

  def make_reservation(room,start_date, end_date)
    unless @rooms.include? room
      raise ArgumentError, "No such room #{room}"
    end
    unless load_availables(start_date, end_date).include? room
      raise ArgumentError, "Room #{room} is not available during this time"
    end
    reservation = Reservation.new(room, start_date, end_date, @room_rate)
    @reservations.push(reservation)
    return reservation
  end

  def make_block(rooms, start_date, end_date)
    id = @blocks.length + 1
    block = Block.new(id, rooms, start_date, end_date)
    @blocks.push(block)
    return block
  end

  def free_rooms
    reserved = []
    @reservations.each do |reservation|
      reserved << reservation.room
    end
    return @rooms - reserved.uniq
  end

  # def load_availables(start_date, end_date)
  #   available_rooms = []
  #   all_available = []
  #   @reservations.each do |reservation|
  #     if start_date >= reservation.dates.last || end_date <= reservation.dates.first
  #       available_rooms << reservation.room
  #     end
  #   end
  #   all_available = (available_rooms + free_rooms).uniq
  #   return all_available
  # end

  def load_reservation(date)
  @reservations.select { |res| res.contains(date) }
  end
  def build_block(num_rooms, start_date, end_date, rate)
    rooms = available_rooms(start_date, end_date)
    if rooms.length < num_rooms
      raise AlreadyReservedError("Not enough rooms available")
    end

    block = Block.new(rooms.first(num_rooms), start_date, end_date, rate)
    @blocks << block
    return block
  end
  def reserve_from_block(block)
    room = block.reserve_room
    reservation = Reservation.new(room, block.start_date, block.end_date, block.room_rate)
    return reservation
  end






end
