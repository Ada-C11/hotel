require 'date'
require 'pry'
require_relative '../lib/rooms_manager.rb'
require_relative '../lib/time_manager.rb'

module Hotel
class  Booking
# Reservations will create a reservation and stimate prices 
  attr_reader :room_id, :rooms, :total_cost, :booking_period

def initialize
   @room_id = room_id
   @rooms = rooms
   @total_cost = total_cost 
   @booking_period = reservation_dates 
   #@current_reservations = [] ? 
end

# method to create rooms 
def load_rooms
    rooms = []
    room_ids = (1..20).to_a
    room_ids.each do |num|
      rooms << Rooms.new(num)
    end
    return rooms
end 

end
end 
end 

