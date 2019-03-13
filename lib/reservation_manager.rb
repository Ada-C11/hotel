require "pry"
require "date"

class Reservation_Manager
  attr_reader :rooms, :all_reservations, :available_rooms

  def initialize
    @all_reservations = all_reservations || []
    # @available_rooms = (1..20).map { |i| i }
    # @all_rooms = all_rooms
  end

  def parse_dates(date_1, date_2)
    date_1 = Date.parse(date_1)
    date_2 = Date.parse(date_2)
  end

  ##TODO: break up method into mini methods (SRP)
  def make_reservation(check_in, check_out)
    fixed_check_in = Date.parse(check_in)
    fixed_check_out = Date.parse(check_out)

    ## TO DO: think about changing id
    reservation = Reservation.new(1)
    reservation.check_in = fixed_check_in
    reservation.check_out = fixed_check_out
    ##TODO: should people be able to make a reservation for one day, same checkin/checkout date?
    if reservation.check_out - reservation.check_in <= 0
      raise ArguementError, "Check out time is not after check in time. Inputted check in date was #{check_in} and check out date was #{check_out}"
    end

    #change @available_rooms to reflect the reservation being made for that date
    available_rooms = find_available_rooms(check_in, check_out)
    if @available_rooms.length > 0
      reservation.room = available_rooms[0]
    else
      raise ArgumentError, "There are no available rooms at the moment. Please try again later!"
    end

    # change available room used to not available. but make available after date passes.
    # reservation_date_range = (reservation.check_in...reservation.check_out).to_a
    all_reservations << reservation
    return reservation
  end

  def find_available_rooms(finding_check_in, finding_check_out)
    @available_rooms = (1..20).map { |i| i }
    # binding.pry
    date1 = Date.parse(finding_check_in)
    date2 = Date.parse(finding_check_out)
    if date1 == date2
      given_date_range = (date1..date2).to_a
    else
      given_date_range = (date1...date2).to_a
    end
    # binding.pry

    unavailable_rooms = []
    all_reservations.each do |reservation|
      day_in = reservation.check_in
      day_out = reservation.check_out
      reserve_date_range = (day_in...day_out).to_a
      combined_ranges = (given_date_range + reserve_date_range).flatten
      # binding.pry
      if combined_ranges.length != combined_ranges.uniq.length
        unavailable_rooms << reservation
      end
    end

    if unavailable_rooms.length > 0
      unavailable_rooms.each do |reservation|
        available_rooms.delete_if { |room_num| room_num == reservation.room }
      end
    end

    return available_rooms
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
