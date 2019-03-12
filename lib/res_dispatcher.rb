require_relative "hotel"
require_relative "room"
require_relative "booking"
require_relative "date"

class ResDispatcher
  attr_reader :room, :date, :booking

  def find_available_room(date)
    eligible_dates = goes into current booking. Checks key for specific date
    if no date then eligile date = date
      if date checks hash for the room numbers
        saves all those room numbers
        checks if room class has rooms that does not include rooms in that array
      end
  end

  def request_booking(date)
    room = find_available_room
    date = date

    input = {
      room: room,
      cost: 200
      date: date
    }
    rosalyn = Booking.new('rosalyn')

    date.accept_trip(trip)
    find_room(room_id).add_trip(trip)
    @bookings << booking
    return booking
  end

#   private

#   def connect_bookings
#     @bookings.each do |trip|
#       room = find_room(trip.room_id)
#       date = find_date(trip.date_id)
#       trip.connect(room, date)
#     end
#     bookings
#   end
# end
end

require 'date'

class Calendar

  def self.is_available?
    duration = @end_date - @start_date
    duration.to_i 
  end

  def self.make_reservation
    create instance of booking and return it
  end
end