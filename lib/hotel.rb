require 'set'

require_relative 'reservation'

class Hotel
  # rooms 1-20, reservations
  def initialize()
    @reservations = []
  end

  # Access the list of all of the rooms in the hotel.
  def get_rooms
    Set[1..20]
  end

  def make_reservation(start_date, end_date)
    # Validate the date range.
    validate_date_range(start_date, end_date)
    # Find room that's available.
    available_rooms = find_available_rooms(start_date, end_date)
    room_number = available_rooms.to_a.sample
    # Create reservation.
    reservation = Reservation.new(room_number, start_date, end_date)
    # Store the reservation.
    reservations << reservation
    # Return the reservation.
    return reservation
  end

  def find_available_rooms(start_date, end_date)
    available_rooms = get_rooms
    @reservations.each do |reservation|
      if reservation.start_date < end_date && reservation.end_date > start_date
        available_rooms.delete(reservation.room_number)
      end
    end
    return available_rooms
  end

  def validate_date_range(start_date, end_date)
    # Test if date is after now (time.now).
    # raise ArgumentError "start date is before now" unless start_date >= Time.now
    # If end date is before start date.
    raise ArgumentError.new("the end date is before start date") unless end_date >= start_date
    # Check if dates are real ie 12/33 (raised_exception).
    # Research in rubys date gem? maybe time library.
  end

  def get_reservations_inclusive(date)
    @reservations.find_all {|reservation| reservation.end_date >= date && reservation.start_date <= date}
  end

end
