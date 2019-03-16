require_relative "reservation"
require "pry"

class Reservation_manager
  attr_reader :reservations, :pending_reservations_for_blocks

  def initialize
    @reservations = []
    @pending_reservations_for_blocks = []
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

    @pending_reservations_for_blocks.each do |pending_block_reservation|
      date_range = (pending_block_reservation.check_in_time...pending_block_reservation.check_out_time).to_a
      combined_range = date_range + date_range_of_interest

      if combined_range.length != combined_range.uniq.length
        available_rooms.delete(pending_block_reservation.room_number)
      end
    end

    return available_rooms
  end

  def find_available_rooms_in_a_block(block_id)
    available_rooms_in_block = []
    @pending_reservations_for_blocks.each do |pending_block_reservation|
      if pending_block_reservation.reservation_id == block_id && !@reservations.include?(pending_block_reservation)
        available_rooms_in_block << pending_block_reservation.room_number
      end
    end
    # binding.pry
    return available_rooms_in_block
  end

  def make_reservation(room_number, reservation_id: 0, check_in_time: Date.today.to_s, check_out_time: (Date.today + 1).to_s, part_of_block: false)
    list_of_available_rooms = find_available_rooms(check_in_time, check_out_time)

    if list_of_available_rooms.include?(room_number)
      new_reservation = Reservation.new(room_number, reservation_id: reservation_id, check_in_time: check_in_time, check_out_time: check_out_time, part_of_block: part_of_block)
      @reservations << new_reservation
    else
      raise ArgumentError, "You cannot book this room for this date range because it conflicts with another reservation"
    end
    return new_reservation
  end

  def make_reservation_from_block(block_id)
    # list_of_available_rooms_in_block = find_available_rooms_in_a_block(block_id)

    available_rooms_in_block = []
    @pending_reservations_for_blocks.each do |pending_block_reservation|
      if pending_block_reservation.reservation_id == block_id
        available_rooms_in_block << pending_block_reservation
      end
    end

    #   # if available_rooms_in_block.empty?
    #   #   raise ArgumentError, "You cannot book a room from this hotel block"
    #   # end

    booked_from_block = available_rooms_in_block.sample
    @reservations << booked_from_block

    return booked_from_block
  end

  def reserve_hotel_block(block_id, check_in, check_out, array_of_rooms, discounted_room_rate)
    list_of_available_rooms = find_available_rooms(check_in, check_out)
    block = []

    if array_of_rooms.length < 1 || array_of_rooms.length > 5
      raise ArgumentError, "Hotel blocks cannot be reserved for more than 5 rooms"
    else
      if (list_of_available_rooms + array_of_rooms).uniq == list_of_available_rooms
        array_of_rooms.each do |block_room_number|
          block_spot = Reservation.new(block_room_number, reservation_id: block_id, check_in_time: check_in, check_out_time: check_out, part_of_block: true)
          block << block_spot
          @pending_reservations_for_blocks << block_spot
        end
      else
        raise ArgumentError, "Some or all of these rooms are unavailable for this date range"
      end
    end
    # binding.pry
    return block
  end

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
