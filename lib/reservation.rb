require 'date'
# require_relative 'hotel'
require_relative 'room'

module HotelManagementSystem
    class Reservation
        attr_reader :guest_name, :start_date, :end_date
        attr_accessor :room_number, :status, :cost
        
        ROOM_NUMBER = (1..20).to_a
        STATUS = [:AVAILABLE, :UNAVAILABLE]
        COST = 200

        def initialize(guest_name:, start_date:, end_date:, room_number:, status: :AVAILABLE, cost: COST)
            @guest_name = guest_name
            @start_date = start_date
            @end_date = end_date
            @room_number = room_number
            @status = status

            if @guest_name.nil?
                raise ArgumentError, "Guest name is required for reservation."
            end

            if !@end_date.nil? && @end_date < @start_date
                raise ArgumentError.new("End date before start date.")
            end

            if @start_date.nil?
                raise ArgumentError, "Reservation start date required."
            end
            
            if @end_date.nil?
                raise ArgumentError, "Reservation end date required."
            end
              
        end

        def available_rooms
            available_rooms = { @room_number => @status}
            # changes the status of a room from available to unavailable when booked
            first_available_driver[0].status = :UNAVAILABLE
          return available_rooms
        end

        def reserve_room(guest_name)
            first_available_room = @room_number
            
          return
        end

        def duration
            duration = (@end_date - @start_date).to_i

          return duration
        end
    end
end