# module Booking
#   class Block(checkin_date, checkout_date, requested_rooms, discounted_rate)
#   block_of_rooms = []
#   i = 0
#   requested_rooms.length.times do |reservation|
#     if !check_availability(checkin_date, checkout_date).include?(requested_rooms[i])
#       raise ArgumentError, "This room is not available for your selected dates."
#     else
#       reservation = Booking::Reservation.new(requested_rooms[i], checkin_date, checkout_date, cost: discounted_rate)
#       block_of_rooms << reservation
#     end
#     i += 1
#   end
#   return block_of_rooms
#   end
# end
