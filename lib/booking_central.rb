#require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'
require_relative 'block'

class BookingCentral 
  attr_accessor :rooms, :all_reservations, :blocks
  
  def initialize
    @blocks = []
    @rooms = (1..20).to_a
    @all_reservations = []
  end

  def reservations_by_date(check_in, check_out)
    asking_date = DateRange.generate_date_range(check_in, check_out)
    matching_reservations = @all_reservations.select { 
      |reservation, details| reservation if DateRange.dates_overlap?(reservation.date_range, asking_date)
    }
    return matching_reservations
  end

  def list_available_rooms(check_in, check_out)
    asking_date = DateRange.generate_date_range(check_in, check_out)
    available_rooms = @rooms - (reservations_by_date(check_in, check_out)).map{ |reservation| reservation.room }
    #available_rooms -= @rooms.select{ |room| room.blocked == true }
    return available_rooms
  end

  def assign_room(check_in, check_out)
    random_available_room = list_available_rooms(check_in, check_out).sample
    return random_available_room
  end

  def reserve_room(check_in:, check_out:, room: nil)
    room ||= assign_room(check_in, check_out)
    unless room
      raise ArgumentError, "There is no availability for the dates provided."
    end

    new_reservation = Reservation.new(
      check_in: check_in, 
      check_out: check_out, 
      room: assign_room(check_in, check_out))
    @all_reservations << new_reservation
    return new_reservation
  end

  def block_rooms(check_in:, check_out:, number_of_rooms:, rooms:, discount_rate:)
    available_rooms = list_available_rooms(check_in, check_out)
    number_of_rooms.times do |i|
      room = assign_room(check_in, check_out)
      @rooms << room
      #@rooms.map{ |room| room.blocked == true }
    end

    if available_rooms.count < number_of_rooms
      raise ArgumentError, "There aren't enough rooms for the dates provided."

    elsif number_of_rooms > 5
      raise ArgumentError, "No more than 5 rooms can be blocked."

    else
      new_block = Block.new(
        check_in: check_in, 
        check_out: check_out, 
        number_of_rooms: number_of_rooms,
        rooms: rooms, 
        discount_rate: 180
        )

        @blocks << new_block
        return new_block
    end
  end

  def list_blocked_rooms
    blocked_rooms = []
    if blocks == []
      raise ArgumentError, "There are no blocked rooms at the moment."
    else
      blocked_rooms = @rooms.select{ |room| room }
    end
    return blocked_rooms
  end
end


