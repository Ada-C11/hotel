require "time"
require "date"

require_relative "room"
require_relative "reserve"
require_relative "date_range"
require_relative "blocks"

class RoomBooker
  class NotReservableError < StandardError; end
  ROOM_PRICE = 200
  BLOCK_DISCOUNT = 150

  attr_reader :reservations, :rooms, :list_reservations, :rate

  def initialize
    @rooms = (1..20).to_a
    @reservations = []
    @blocked_reservations = []
  end

  def book_reservation(room, check_in, check_out)
    unless @rooms.include?(room)
      raise ArgumentError, "#{room} does not exist"
    end

    unless find_available_room(check_in, check_out).include? room
      raise NotReservableError, "#{room} is already booked for the given dates"
    end

    reservation_request = Reservation.new(room, check_in, check_out, rate)
    @reservations << reservation_request
    return reservation_request
  end

  def list_reservations(date)
    @reservations.select { |res| res.contains(date)}
  end

  def find_available_room(check_in, check_out)
    dates = DateRange.new(check_in, check_out)
    available_rooms = @rooms

    overlaping_reservations = @reservations.select { |res| res.overlaps(dates) }
    reserved_rooms = overlaping_reservations.map { |res| res.room_booked }

    available_rooms -= reserved_rooms
    return available_rooms
  end
end
