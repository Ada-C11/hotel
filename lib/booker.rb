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

  attr_reader :reservations, :rooms, :list_reservations

  def initialize(rooms:)
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
    reserved_rooms = overlaping_reservations.map { |res| res.room }

    available_rooms -= reserved_rooms
    return available_rooms
  end

  # working on blocked rooms

  def reserve_block(check_in, check_out, rooms_needed)
    raise ArgumentError if rooms_needed > 5
    block_of_rooms = []

    rooms_needed.times do
      room = find_available_room(check_in: check_in, check_out: check_out)
      room.booked_on(check_in: check_in, check_out: check_out)
      block_of_rooms << room
    end

    if block_of_rooms.length < rooms_needed
      raise ArgumentError, "We cannot book this block reservation due to insufficient room availability"
    elsif block_of_rooms.length > 5
      raise ArgumentError, "We cannot block more than 5 rooms per party."
    end

    make_block = BlockParty.new(check_in: check_in, check_out: check_out, blocked_rooms: block_of_rooms, discount: 150)
    return make_block
  end
end
