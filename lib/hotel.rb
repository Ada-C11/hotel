class Hotel

  #rooms 1-20, reservations
  def initialize()
    @reservations = [] #array of reservations
  end

  def get_rooms
    Array(1..20)
  end

  def make_reservation(start_date, end_date)
    # Validate the date range.
    validate_date_range(start_date, end_date)
    # Find room thats available.
    overlapping_reservations = @reservations.find_all
    # Create reservation.
    reservation = Reservation.new(room_number,start_date,end_date)
    # Store the reservation.
    reservations << reservation
    # Return the reservation.
    return reservation
  end

  def validate_date_range(start_date, end_date)
    # Test if date is after now (time.now).
    raise "start date is before now" unless start_date > Time.now
    # If end date is before start date.
    raise "the end date is before start date" unless end_date >= start_date
    # Check if dates are real ie 12/33 (raised_exception).
    # Research in rubys date gem? maybe time library.

  end

  def get_reservations_inclusive(date)
    @reservations.find {|reservation| reservation.end_date >= date && reservation.start_date <= date}
  end

end

class Reservation
  @room_price = 200

  #room association, date range
  def initialize(room_number, start_date, end_date)
    @room_number = room_number #integer
    @start_date = start_date #time
    @end_date = end_date #time
  end

  def calculate_total_cost()
    total_nights = @end_date - @start_date - 1 #probably convert to integer after test
    @room_price * total_nights
  end
end
