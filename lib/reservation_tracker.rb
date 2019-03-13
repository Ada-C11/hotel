require_relative "reservation"
require_relative "room"
require "date"
require "pry"

class ReservationTracker
  attr_reader :total_room
  attr_accessor :room, :reservation, :date, :reservations

  def initialize
    @room = room
    @reservation = reservation
    @date = date
    @total_room = total_room
    @reservations = []
  end

  def total_room
    return @total_room = (1..20).to_a
  end

  def is_valid?(start_date, end_date)
  end

  def add_reservation(name, room_id, start_date, end_date)
    @new_reservation = Reservation.new(name: name, room_id: room_id, start_date: start_date, end_date: end_date)
    # include a is_valid method here to check if the reservation is valid before adding it to a list of reservation
    @reservations << @new_reservation
  end
end

# binding.pry
