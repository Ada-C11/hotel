require 'date'
require 'pry'
require_relative '../lib/rooms_manager.rb'
require_relative '../lib/time_manager.rb'
require_relative '../lib/booking_manager.rb'


module Hotel
    class ReservationsManager
      # should handle the business logic for bookings
      attr_reader :rooms, :reservations, :reserved_rooms, :available_rooms 
      def initialize
        @rooms = load_rooms
        @reservations = []
        @reserved_rooms = []
        @available_rooms = available_rooms
      end

    # def load_rooms ??? 
    #     rooms = []
    #     room_ids = (1..20).to_a
    #     room_ids.each do |num|
    #       rooms << Rooms.new(num)
    #     end
    #     return rooms
    # end



    end
end 