require "date"
require "datespans.rb"

@reservations = []
@rooms = [1..20]

def list_available_rooms(date_range)
  standing_reservations = availability_by_dates(date_range)

  available_rooms = @rooms.reject do |room|
    conflicting_reservations.find do |booking|
      booking.room_number == room[:room_number]
    end
  end
  return available_rooms
end

def reservations_by_date(date)
  date = Date.parse(date)
  res_by_date = @reservations.select do |booking|
    booking.date_range.included_in_date_range(date)
  end
  return res_by_date
end

def reservation_list(date_span)
  reservations_list = @reservations.select do |booking|
    booking.date_range.overlaps?(date_range)
  end
  return reservations_list
end