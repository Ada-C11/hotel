require_relative "reservation"
require_relative "hotel_block"
require "date"
require "pry"

class ReservationTracker
  attr_reader :total_room
  attr_accessor :reservations, :reservations_per_room, :block_reservations

  def initialize
    @total_room = (1..20).to_a
    @reservations = []
    @reservations_per_room = {}
    @block_reservations = {}
  end

  def reservations_by_date(date)
    res_date = Date.parse(date)
    reservations_at_date = @reservations.select { |reservation| reservation.contain_date?(res_date) }
    return reservations_at_date
  end

  def same_daterange?(start_date, end_date, reservation)
    return reservation.start_date == start_date && reservation.end_date == end_date
  end

  def list_avail_room(start_date, end_date)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    available_room = []
    @total_room.each do |room_id|
      is_room_available = (@reservations_per_room[room_id] == nil || is_date_range_available?(start_date, end_date, @reservations_per_room[room_id]))
      is_block_available = (@block_reservations[room_id] == nil || is_date_range_available?(start_date, end_date, @block_reservations[room_id]))
      if is_room_available && is_block_available
        available_room << room_id
      end
    end
    return available_room
  end

  def avail_block_room(new_block)
    reserved_rooms = []
    @reservations.each do |reservation|
      if same_daterange?(new_block.start_date, new_block.end_date, reservation)
        reserved_rooms << reservation.room_id
      end
    end
    return new_block.rooms - reserved_rooms
  end

  def add_reservation(name, room_id, start_date, end_date)
    parsed_start_date = Date.parse(start_date)
    parsed_end_date = Date.parse(end_date)
    add_reservation_with_parsed_date(name, room_id, parsed_start_date, parsed_end_date)
  end

  def add_reservation_for_block(block, name, room_id)
    (0..@block_reservations[room_id].length - 1).each do |i|
      if same_daterange?(@block_reservations[room_id][i].start_date, @block_reservations[room_id][i].end_date, block)
        @block_reservations[room_id].delete_at(i)
      end
    end
    add_reservation_with_parsed_date(name, room_id, block.start_date, block.end_date)
  end

  def add_hotelblock(start_date, end_date, rooms, discounted_rate)
    parsed_start_date = Date.parse(start_date)
    parsed_end_date = Date.parse(end_date)

    rooms.each do |room_id|
      reservations_by_room = @reservations_per_room[room_id]

      if reservations_by_room != nil && !is_date_range_available?(parsed_start_date, parsed_end_date, reservations_by_room)
        raise ArgumentError, "One or more room in the Hotel Block is not available"
      end
    end
    new_block = HotelBlock.new(start_date: start_date, end_date: end_date, rooms: rooms, discounted_rate: discounted_rate)
    rooms.each do |room_id|
      if @block_reservations[room_id] == nil
        @block_reservations[room_id] = []
      end
      @block_reservations[room_id] << new_block
    end
    return new_block
  end

  private

  def is_date_range_available?(start_date, end_date, reservations)
    reservations.each do |reservation|
      if reservation.is_overlap?(start_date, end_date)
        return false
      end
    end
    return true
  end

  def add_reservation_with_parsed_date(name, room_id, parsed_start_date, parsed_end_date)
    reservations_by_room = @reservations_per_room[room_id]

    if (reservations_by_room == nil || is_date_range_available?(parsed_start_date, parsed_end_date, reservations_by_room)) && (@block_reservations[room_id] == nil || is_date_range_available?(parsed_start_date, parsed_end_date, @block_reservations[room_id]))
      @new_reservation = Reservation.new(name: name, room_id: room_id, start_date: parsed_start_date, end_date: parsed_end_date)
      @reservations << @new_reservation

      if @reservations_per_room[room_id] == nil
        @reservations_per_room[room_id] = []
      end

      @reservations_per_room[room_id] << @new_reservation
    else
      raise ArgumentError, "The room is not available"
    end
  end
end

# binding.pry
