require_relative "reservation"
require_relative "room"
require "date"
require "pry"

class ReservationTracker
  attr_reader :total_room
  attr_accessor :reservations, :reservations_per_room

  def initialize
    @total_room = (1..20).to_a
    @reservations = []
    @reservations_per_room = {}
  end

  def reservations_by_date(date)
    res_date = Date.parse(date)
    reservations_at_date = @reservations.select { |reservation| reservation.start_date == res_date }
    return reservations_at_date
  end

  def is_overlap?(start_date, end_date, resservation)
    return resservation.end_date > start_date && resservation.start_date < end_date
  end

  def is_date_range_available?(start_date, end_date, reservations)
    reservations.each do |reservation|
      if is_overlap?(start_date, end_date, reservation)
        return false
      end
    end
    return true
  end

  def list_avail_room(start_date, end_date)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    available_room = []
    @total_room.each do |room_id|
      if @reservations_per_room[room_id] == nil || is_date_range_available?(start_date, end_date, @reservations_per_room[room_id])
        available_room << room_id
      end
    end
    return available_room
  end

  def add_reservation(name, room_id, start_date, end_date)
    available_room = list_avail_room(start_date, end_date)
    if !available_room.include? room_id
      raise ArgumentError, "The room is not available"
    else
      @new_reservation = Reservation.new(name: name, room_id: room_id, start_date: start_date, end_date: end_date)
      @reservations << @new_reservation
      if @reservations_per_room[room_id] == nil
        @reservations_per_room[room_id] = []
      end
    end
    @reservations_per_room[room_id] << @new_reservation
  end
end

# binding.pry
