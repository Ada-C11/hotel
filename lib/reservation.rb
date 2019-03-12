require 'date'
# require_relative 'hotel'
require_relative 'room'

module HotelManagementSystem
    class Reservation
        attr_reader :guest_name, :start_time, :end_time
        attr_accessor :room_number, :status, :cost
        
        ROOM_NUMBER = (1..20).to_a
        STATUS = [:AVAILABLE, :UNAVAILABLE]
        COST = 200

        def initialize(guest_name:, start_time:, end_time:, room_number:, status: :AVAILABLE, cost: COST)
            @guest_name = guest_name
            @start_time = start_time
            @end_time = end_time
            @room_number = room_number
            @status = status

            if @guest_name.nil?
                raise ArgumentError, "Guest name is required for reservation."
            end

            if !@end_time.nil? && @end_time < @start_time
                raise ArgumentError.new("End time before start time.")
            end

            if @start_time.nil?
                raise ArgumentError, "Reservation start time required."
            end
            
            if @end_time.nil?
                raise ArgumentError, "Reservation end time required."
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
            duration = (@end_time - @start_time).to_i
            
          return duration
        end
    end
end