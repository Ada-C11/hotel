# require 'date'
# # require_relative 'hotel.rb'

# module Booking
#   class Block

#     attr_reader :checkin_date, :checkout_date, :requested_rooms, :discounted_rate, :party_name, :room_block, :block_of_rooms, :all_rooms, :max_rooms, :room_numbers, :hotel, :rooms
    
#     # attr_accessor :hotel, :rooms

#     def initialize(checkin_date, checkout_date, requested_rooms, discounted_rate, hotel: nil)
#     @checkin_date = checkin_date
#     @checkout_date = checkout_date 
#     @block_of_rooms ||= []

#     requested_rooms.each do |room|
#       if @block_of_rooms.include?(room)
#         raise ArgumentError, "That room is already in a block."
#       else
#         @requested_rooms = requested_rooms
#       end
#     end
#     @hotel ||= hotel
#     @room_block = []
    
#     @room_numbers = room_numbers
    
#     @available_rooms = available_rooms
#     @all_rooms = all_rooms
#     @discounted_rate = discounted_rate
#     @party_name = party_name
    

#   end

#     def room_numbers
#       i = 0

#       requested_rooms.each do |room|
#         unless @available_rooms == nil
#           if !@available_rooms.include?(room)
#             raise ArgumentError, "That room is unavailable."
#           end
#         end

#         if requested_rooms.length > 5
#           raise ArgumentError, "A block can have 5 rooms maximum."
#         else
#           @hotel.all_rooms.each do |room|
#             if room.number == requested_rooms[i]
#             reserved_room = room
#             @room_block << reserved_room
#             end
#           end
#         i += 1
#       end
#     end
#       @room_numbers = @room_block.map do |room|
#       room.number
#       end
    
      
#       @block_of_rooms << @room_numbers
#     return @room_numbers
#   end
    
#     def available_rooms
#       if @room_numbers != nil
#         @available_rooms = hotel.check_availability(checkin_date, checkout_date) - @room_numbers
     
#       elsif @hotel.available_rooms == nil
#         raise ArgumentError, "There are no available rooms."
#       end
#      return @available_rooms
#     end

#   # END OF CLASS
#   end

#   def block_availability(block)
#     available_rooms = []
#     block.each do |room|
#       available_rooms << room.number
#     end
#     return available_rooms
#   end
# # END OF MODULE
# end

