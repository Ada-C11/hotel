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

  def reserve_room(check_in:, check_out:)
    new_reservation = Reservation.new(check_in: check_in, check_out: check_out)
    @all_reservations << new_reservation
    return new_reservation
  end

end


