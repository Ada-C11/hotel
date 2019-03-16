require "pry"
require "date"

class Reservation_Manager
  attr_reader :rooms, :all_reservations, :available_rooms
  attr_accessor :all_block_reservations

  def initialize
    @all_reservations = all_reservations || []

    #this is simply a list of rooms, regardless of availability
    # @available_rooms = (1..20).map { |i| i }

    #these are not actual reservations but rooms set aside
    #TODO: change variable name to reflect above
    @all_block_reservations = all_block_reservations || []
  end

  def parse_dates(date_1, date_2)
    date_1 = Date.parse(date_1)
    date_2 = Date.parse(date_2)
  end

  ##TODO: break up method into mini methods (SRP)
  def make_reservation(check_in, check_out, is_hotel_blocker: false, block_id: nil)
    # TODO: BETTER NAMES FOR CHECK IN/OUT TIME
    fixed_check_in = Date.parse(check_in)
    fixed_check_out = Date.parse(check_out)

    if is_hotel_blocker == true
      #reservation_id for hotel block rooms are all the same
      reservation = Reservation.new(block_id, is_hotel_blocker: true)

      # find the hotel block date range user is trying to reserve for
      # reassign checkin/checkout date to match block dates
      all_block_reservations.each do |block_reservation|
        if block_id == block_reservation.reservation_id
          reservation.check_in = block_reservation.check_in
          reservation.check_out = block_reservation.check_out
        end
      end

      #reassign room for hotel blocker and erase hold for room
      rooms_for_block = all_block_reservations.map { |block_instance| block_instance.room }
      reservation.room = rooms_for_block[0]
      all_block_reservations.shift
    else #IF RESERVATION IS OUTSIDE OF BLOCK
      reservation = Reservation.new(1)
      reservation.check_in = fixed_check_in
      reservation.check_out = fixed_check_out

      available_rooms = find_available_rooms(check_in, check_out)
      if available_rooms.length > 0
        reservation.room = available_rooms[0]
      else
        raise ArgumentError, "There are no available rooms at the moment. Please try again later!"
      end
    end

    all_reservations << reservation
    return reservation
  end

  def make_hotel_block(block_id, check_in, check_out, room_num)
    # fixed_check_in = Date.parse(check_in)
    # fixed_check_out = Date.parse(check_out)
    if room_num > 5
      raise ArgumentError, "You cannot make a hotel block of larger than 5 rooms at at time."
    end

    #find list of available rooms.
    available_block_rooms = find_available_rooms(check_in, check_out)

    #grabs number of rooms from available room list - for hotel block users only if there are enough rooms left
    if available_block_rooms.length >= room_num
      block_rooms = available_block_rooms.take(room_num)
      # [1,2,3,4,5]

      #adds blocked rooms into all_block_reservations array
      block_rooms.each do |num|
        new_block_room = Reservation.new(block_id, check_in: check_in, check_out: check_out, is_hotel_blocker: true)
        new_block_room.room = num
        all_block_reservations << new_block_room
        # binding.pry
      end
    else
      raise ArgumentError, "Sorry, we don't have enough rooms available for your rooms in a block."
    end

    # should return room numbers
    return block_rooms
  end

  def find_available_rooms(finding_check_in, finding_check_out)
    available_rooms = (1..20).map { |i| i }
    date1 = Date.parse(finding_check_in)
    date2 = Date.parse(finding_check_out)
    if date1 == date2
      given_date_range = (date1..date2).to_a
    else
      given_date_range = (date1...date2).to_a
    end

    #making make_reservation rooms unavailable
    unavailable_rooms = []
    all_reservations.each do |reservation|
      day_in = reservation.check_in
      day_out = reservation.check_out
      reserve_date_range = (day_in...day_out).to_a

      combined_ranges = (given_date_range + reserve_date_range).flatten

      if combined_ranges.length != combined_ranges.uniq.length
        unavailable_rooms << reservation
      end
    end

    if unavailable_rooms.length > 0
      unavailable_rooms.each do |reservation|
        available_rooms.delete_if { |room_num| room_num == reservation.room }
      end
    end

    #find hotel block rooms for specific date
    #hotel_block is array of rooms blocked per dates
    hotel_block = []
    all_block_reservations.each do |reservation|
      day_in = reservation.check_in
      day_out = reservation.check_out
      reserve_date_range = (day_in...day_out).to_a
      combined_ranges = (given_date_range + reserve_date_range).flatten

      if combined_ranges.length != combined_ranges.uniq.length
        hotel_block << reservation
      end
    end

    #make hotel_block rooms unavailable
    #take away hotel block rooms from the available_rooms
    if hotel_block.length > 0
      hotel_block.each do |block_reservation|
        available_rooms.delete_if { |room_num| room_num == block_reservation.room }
      end
    end

    return available_rooms
  end

  def find_block_availability(block_id)
    block_rooms = []
    all_block_reservations.each do |held_reservations|
      if block_id == held_reservations.reservation.id
        block_rooms << held_reservations.room
      end
    end
    return block_rooms
  end

  def find_reservation_date(check_in, check_out)
    date1 = Date.parse(check_in)
    date2 = Date.parse(check_out)
    given_date_range = (date1...date2).to_a

    #TODO: find enumerable method that works
    found_reservations = []
    all_reservations.each do |reservation|
      day_in = reservation.check_in
      day_out = reservation.check_out
      reserve_date_range = (day_in...day_out).to_a
      if given_date_range == reserve_date_range
        found_reservations << reservation
      end
    end

    return found_reservations
  end

  # def all_rooms
  #   all_rooms = []
  #   20.times do |i|
  #     room = {}
  #     room["room_id"] = i + 1
  #     room["booked_date"] = []
  #     all_rooms << room
  #   end
  #   return all_rooms

  #  [
  #     {room_id: 1,
  #     booking_dates: [
  #                     [firstdates],
  #                     [seconddates]]
  #        },
  #     {room_id: 2,
  #      booking_dates: [
  #                     [firstdates],
  #                     [seconddates]]
  #      }
  #   ]

  # end
end

# create array of available rooms
### FINISH THIS LOOP
### think about using .include? to scan booking_dates array
# available_rooms = []
# rooms.each do |room_dates|
#    if room_dates.length == 0
#     available_rooms << room
#    else
#     reservation_date_range.each do |reserve_date|
#         if reserve_date != room_date[]
#    end
# end

# all_reservations.each do |reservation|
#   reservation_booked_dates = reservation.room["booked_date"].flatten
#   if reservation_booked_dates == given_date_range
#     found_reservations << reservation
#   end
# end
# return found_reservations
