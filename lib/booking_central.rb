require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'

class BookingCentral 
  attr_accessor :rooms, :all_reservations
  
  def initialize
    @rooms = []
    @all_reservations = []

    (1..20).each do |number|
      room = Room.new(number, room_reservations: [])
      @rooms << room
    end
  end

  def assign_room
    if @all_reservations.length == 0
      assigned_room = @rooms.sample
    else
      available_rooms = @all_reservations.reject{ |k,v| k.room }
      assigned_room = available_rooms.sample
    end
    return assigned_room.number
  end

  # bookings = BookingCentral.new
  # puts bookings.assign_room
  
  

  def reserve_room(check_in:, check_out:)
    new_reservation = Reservation.new(check_in: check_in, check_out: check_out)
    @all_reservations << new_reservation
    return new_reservation
  end

  def reservations_by_date(check_in)
    matching_reservations = @all_reservations.select { |k, v| k.room if k.date_range.include?(check_in) }
    return matching_reservations
  end
end


