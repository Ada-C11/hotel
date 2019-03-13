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

  def list_available_rooms(check_in, check_out)
    asking_date = DateRange.generate_date_range(check_in, check_out)
    reserved_dates = @all_reservations.select { |reservation, details| reservation.date_range }

    if reserved_dates == []
      available_rooms = @rooms
    else
      check_overlap = DateRange.dates_overlap?(reserved_dates, asking_date)
      available_rooms = @all_reservations.select{ |reservation, details| reservation.room unless check_overlap == true}
    end  
  end

  # bookings = BookingCentral.new
  # puts bookings.list_available_rooms('2019-04-01', '2019-04-03')

  def assign_room
    if @all_reservations.length == 0
      assigned_room = @rooms.sample
    else
      available_rooms = @all_reservations.reject{ |k,v| k.room }
      assigned_room = available_rooms.sample
    end
    return assigned_room
  end

  # bookings = BookingCentral.new
  # puts bookings.assign_room
  
  

  def reserve_room(check_in:, check_out:, room: self.assign_room)
    new_reservation = Reservation.new(check_in: check_in, check_out: check_out, room: assign_room)
    @all_reservations << new_reservation
    return new_reservation
  end

  def reservations_by_date(check_in)
    matching_reservations = @all_reservations.select { |reservation, details| reservation if reservation.date_range.include?(check_in) }
    return matching_reservations
  end
end


