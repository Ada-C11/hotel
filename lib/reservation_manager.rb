require_relative "reservation"
require "pry"

class Reservation_manager
  attr_reader :reservations, :all_rooms, :make_reservation, :find_available_rooms

  def initialize
    @reservations = []
  end

  def find_available_rooms(check_in_time, check_out_time)
    available_rooms = (1..20).to_a
    check_in = Date.parse(check_in_time)
    check_out = Date.parse(check_out_time)

    date_range_of_interest = (check_in...check_out).to_a

    @reservations.each do |reservation|
      date_range = (reservation.check_in_time...reservation.check_out_time).to_a
      combined_range = date_range + date_range_of_interest

      if combined_range.length != combined_range.uniq.length
        available_rooms.delete(reservation.room_number)
      end
    end
    return available_rooms
  end

  def make_reservation(room_number, reservation_id: 0, check_in_time: Date.today.to_s, check_out_time: (Date.today + 1).to_s)
    list_of_available_rooms = find_available_rooms(check_in_time, check_out_time)
    if list_of_available_rooms.include?(room_number)
      new_reservation = Reservation.new(room_number, reservation_id: reservation_id, check_in_time: check_in_time, check_out_time: check_out_time)
      @reservations << new_reservation
    else
      raise ArgumentError, "You cannot book this room for this date range because it conflicts with another reservation"
    end
    return new_reservation
  end

  # def reserve_hotel_block(check_in, check_out, array_of_rooms, discounted_room_rate)
  #   if array_of_rooms < 1 || array_of_rooms > 5
  #     raise ArgumentError, "Hotel blocks cannot be reserved for more than 5 rooms"
  #   else
  #     block = array_of_rooms.map do |block_room_number|
  #       make_reservation(block_room_number, check_in_time: check_in, check_out_time: check_out)
  #     end
  #   end
  #   return block
  # end

  # def reserve_hotel_block(checkin, checkout, rooms, discounted_room_rate)
  #     check if these rooms are available for these dates (if they are not, raise error)
  #     if they are available:
  #       make these rooms unavailable for the general public (they will not be in array of available rooms)
  #       change the price of these rooms to the discounted rate
  #       allow them to be reserved if allowed (maybe add "part_of_block: false" to Reservation.new)
  # end 

  def find_reservations(date)
    date = Date.parse(date)
    reservations_with_date = @reservations.select do |reservation|
      if date.between?(reservation.check_in_time, reservation.check_out_time)
        reservation
      end
    end
    return reservations_with_date
  end
end
