require_relative "reservation"
require_relative "room"
require "date"
require "pry"

class ReservationTracker
  attr_reader :total_room
  attr_accessor :reservations, :reservations_per_room

  def initialize
    #@total_room = total_room
    @reservations = []
    @reservations_per_room = {}
  end

  def total_room
    return @total_room = (1..20).to_a
  end

  def reservations_by_date(date)
    res_date = Date.parse(date)
    reservations_at_date = @reservations.select { |reservation| reservation.start_date == res_date }
    return reservations_at_date
  end

  def list_avail_room(start_date, end_date)
  end

  def add_reservation(name, room_id, start_date, end_date)
    @new_reservation = Reservation.new(name: name, room_id: room_id, start_date: start_date, end_date: end_date)
    # include a is_valid method here to check if the reservation is valid before adding it to a list of reservation
    @reservations << @new_reservation
    if @reservations_per_room[room_id] == nil
      @reservations_per_room[room_id] = []
    end
    @reservations_per_room[room_id] << @new_reservation
  end
end

# binding.pry
