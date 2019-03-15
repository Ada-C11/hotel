#require_relative 'room'
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

  def reservations_by_date(check_in, check_out)
    asking_date = DateRange.generate_date_range(check_in, check_out)
    matching_reservations = @all_reservations.select { |reservation, details| reservation if DateRange.dates_overlap?(reservation.date_range, asking_date) }
    return matching_reservations
  end

  def list_available_rooms(check_in, check_out)
    asking_date = DateRange.generate_date_range(check_in, check_out)
    available_rooms = @rooms - (reservations_by_date(check_in, check_out)).map{ |reservation| reservation.room}
    return available_rooms
  end

  def assign_room(check_in, check_out)
    random_available_room = list_available_rooms(check_in, check_out).sample
    return random_available_room
  end


  def reserve_room(check_in:, check_out:, room: assign_room(check_in, check_out))
    
    if list_available_rooms(check_in, check_out) == []
      raise ArgumentError, "There is no availability for the dates provided."
    else
      new_reservation = Reservation.new(check_in: check_in, check_out: check_out, room: assign_room(check_in, check_out))
      @all_reservations << new_reservation
      return new_reservation
    end
  end

  # bookings = BookingCentral.new
  # new_booking = bookings.reserve_room(check_in: '2019-01-03', check_out: '2019-01-04', room: 1)
  # puts (bookings.assign_room('2019-01-03', '2019-01-04')).number
end


