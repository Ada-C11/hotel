require 'date'
require_relative 'room'
require_relative 'reservation'

module HotelManagementSystem
#     class Hotel
#         attr_accessor :guest, :status
#         COST = 200
#         ROOM_NUMBERS = (1..20).to_a
#         STATUS = [:AVAILABLE, :UNAVAILABLE]

#     def initialize(id:, name:, vin:, status: :AVAILABLE, trips: [])
#         super(id)
    
#         @name = name
#         @vin = vin
#         @status = status.to_sym
#         @trips = trips
    
#         if vin.length != 17
#             raise ArgumentError, "Invalid vin #{vin}."
#         end
    
#         if !STATUS.include?(@status)
#             raise ArgumentError, "Invalid status #{@status}."
#         end
#     end
#  end
end