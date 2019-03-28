require_relative "reservation"

class Reservation_manager
  attr_reader :reservations, :pending_reservations_for_blocks, :all_rooms

  def initialize
    @reservations = []
    @pending_reservations_for_blocks = []
    @all_rooms = (1..20).to_a
  end

  def find_available_rooms(check_in_day, check_out_day)
    available_rooms = (1..20).to_a
    check_in = Date.parse(check_in_day)
    check_out = Date.parse(check_out_day)

    date_range_of_interest = (check_in...check_out).to_a

    overlap_reservations = @reservations.select do |reservation|
      reservation.overlaps(check_in, check_out)
    end 

    reserved_rooms = overlap_reservations.map do |reservation|
      reservation.room_number
    end 

    available_rooms -= reserved_rooms

    @pending_reservations_for_blocks.each do |pending_block_reservation|
      date_range = (pending_block_reservation.check_in_day...pending_block_reservation.check_out_day).to_a
      combined_range = date_range + date_range_of_interest

      if combined_range.length != combined_range.uniq.length
        available_rooms.delete(pending_block_reservation.room_number)
      end
    end

    return available_rooms
  end

  def find_available_rooms_in_a_block(block_id)
    available_rooms_in_block = []

    @pending_reservations_for_blocks.each do |pending_reservation|
      if pending_reservation.reservation_id == block_id
        available_rooms_in_block << pending_reservation.room_number
      end
    end
    @reservations.each do |already_made_reservation|
      if already_made_reservation.reservation_id == block_id
        available_rooms_in_block.delete(already_made_reservation.room_number)
      end
    end

    return available_rooms_in_block
  end

  def make_reservation(room_number, reservation_id: 0, check_in_day: Date.today.to_s, check_out_day: (Date.today + 1).to_s)
    list_of_available_rooms = find_available_rooms(check_in_day, check_out_day)

    if list_of_available_rooms.include?(room_number)
      new_reservation = Reservation.new(room_number, reservation_id: reservation_id, check_in_day: check_in_day, check_out_day: check_out_day)
      @reservations << new_reservation
    else
      raise ArgumentError, "This reservation conflicts with an existing reservation."
    end
    return new_reservation
  end

  def reserve_hotel_block(block_id, check_in, check_out, array_of_rooms, discounted_room_rate)
    list_of_available_rooms = find_available_rooms(check_in, check_out)
    block = []

    if array_of_rooms.length < 2 || array_of_rooms.length > 5
      raise ArgumentError, "Hotel blocks cannot be reserved for less than 2 rooms or more than 5 rooms"
    else
      if (list_of_available_rooms + array_of_rooms).uniq == list_of_available_rooms
        array_of_rooms.each do |block_room_number|
          block_spot = Reservation.new(block_room_number, reservation_id: block_id, check_in_day: check_in, check_out_day: check_out, room_rate: discounted_room_rate)
          block << block_spot
          @pending_reservations_for_blocks << block_spot
        end
      else
        raise ArgumentError, "Some or all of these rooms are unavailable for this date range"
      end
    end
    return block
  end

  def make_reservation_from_block(block_id)
    rooms_available_in_block = find_available_rooms_in_a_block(block_id)

    possible_reservations = []

    raise ArgumentError, "There are no available rooms left for this block." if rooms_available_in_block.length < 1

    @pending_reservations_for_blocks.each do |possible_res|
      if possible_res.reservation_id == block_id
        if rooms_available_in_block.include?(possible_res.room_number)
          possible_reservations << possible_res
        end
      end
    end
    chosen_reservation = possible_reservations.sample
    @reservations << chosen_reservation
    return chosen_reservation
  end

  def find_reservations(date)
    date = Date.parse(date)

    @reservations.select do |reservation|
      reservation.contains(date)
    end 
  end
end
