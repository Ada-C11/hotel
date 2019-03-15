#require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'
require_relative 'block'

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

  def block_rooms(check_in:, check_out:, number_of_rooms:, rooms:, discount_rate:)
    available_rooms = list_available_rooms(check_in, check_out)
    if available_rooms.count < number_of_rooms
      raise ArgumentError, "There are not enough rooms for the dates provided."
    else
      new_block = Block.new(
        check_in: check_in, 
        check_out: check_out, 
        number_of_rooms: number_of_rooms,
        rooms: number_of_rooms.times{assign_room(check_in, check_out)}, 
        discount_rate: 180
        )
    end
  end

  bookings = BookingCentral.new
  blocked = bookings.block_rooms(check_in: '2019-04-01', check_out:'2019-04-02', number_of_rooms: 3, rooms: [], discount_rate: 180)
  puts blocked.rooms.class
  # new_reservation = bookings.reserve_room(check_in: '2019-04-01', check_out:'2019-04-02', room: bookings.assign_room('2019-04-01', '2019-04-02'))
  # puts new_reservation.room.number  
  # puts bookings.list_available_rooms('2019-04-01', '2019-04-02').map{|r| r.number}
  # new_booking = bookings.reserve_room(check_in: '2019-01-03', check_out: '2019-01-04', room: 1)
  # puts (bookings.assign_room('2019-01-03', '2019-01-04')).number
end


