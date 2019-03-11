# require_relative "room"

# module Hotel
#   class Reservation
#     attr_reader :reservation_id, :date_range, :room, :price, :hotel_block, :room_id

#     def initialize(reservation_id:, date_range:, room: nil,
#                    room_id: nil, price: 200, hotel_block: nil)
#       @reservation_id = reservation_id
#       @date_range = date_range
#       @price = price
#       @hotel_block = hotel_block

#       if room
#         @room = room
#         @room_id = room.id
#       elsif room_id
#         @room_id = room
#       else
#         raise ArgumentError, "Room or room id is required"
#       end
#     end
#   end
# end
