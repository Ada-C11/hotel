require_relative "hotel"
require_relative "room"
require_relative "booking"
require_relative "date"

class ResDispatcher
  attr_reader :room, :date, :booking

  def find_room(id)
    Room.validate_id(id)
    if id.zero?
      return raise ArgumentError, "Invalid ID"
    end
    return @rooms.find { |room| room.id == id }
  end

  def find_date(id)
    Date.validate_id(id)
    if id.zero?
      return raise ArgumentError, "Invalid ID"
    end
    return @dates.find { |date| date.id == id }
  end

  def find_available_room
    eligible_date_list = @dates.select { |date| date.status == :AVAILABLE }
    dates_not_driven = eligible_date_list.select { |date| date.bookings.empty? }
    if dates_not_driven.empty?
      stale_date = eligible_date_list.min_by do |date| 
        last_trip = date.bookings.max_by { |booking| booking.end_time }
        last_trip.end_time
      end
      return stale_date
    else
      return dates_not_driven.first
    end
  end

  def request_booking(room_id)
    date = find_available_date
    room = find_room(room_id)

    if room.id == date.id
      raise ArgumentError.new
    end

    input = {
      id: @bookings.length + 1,
      room: room,
      start_time: Time.now.to_s,
      end_time: nil,
      cost: nil,
      rating: nil,
      date: date
    }
    trip = Trip.new(input)

    date.accept_trip(trip)
    find_room(room_id).add_trip(trip)
    @bookings << trip
    return trip
  end

  private

  def connect_bookings
    @bookings.each do |trip|
      room = find_room(trip.room_id)
      date = find_date(trip.date_id)
      trip.connect(room, date)
    end
    bookings
  end
end
end