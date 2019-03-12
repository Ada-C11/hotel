class Reservation
  def initialize(id, room_id, start_date, end_date)
    @id = id
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @room_id = room_id
    if @start_date > @end_date
      raise ArgumentError, "start_date must be before end_date"
    end
  end

  def make_reservation(start_date, end_date)
    id = Hotels.reservations.length + 1
    room_id = Hotel.rooms.sample.to_s
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    reservation = Reservation.new(id, room_id, start_date, end_date)

    @reservations << reservation
  end

  # def make_reservation(start_date, end_date)
  #   # id = reservations.length + 1
  #   #start_date = start_date
  #   #end_date = end_date
  #   #go check the calendar for the date range of reservation and find which room is available
  #   #raise ArgumentError if dates are invalid
  #   #raise exception if no room is available
  #   #Reservation.new(id,start,end,room)
  #   #add the date:room_id pair to the calendar
  #   #add the new reservation to the reservation array
  # end
end
