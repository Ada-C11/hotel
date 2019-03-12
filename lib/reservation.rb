require 'date'
require_relative 'hotel'
require_relative 'room'

module HotelManagementSystem
    class Reservation
        attr_accessor :guest_name, :start_time, :end_time, :room_number, :status
        
        ROOM_NUMBER = (1..20).to_a
        STATUS = [:AVAILABLE, :UNAVAILABLE]
        COST = 200

        def initialize(guest_name:, start_time:, end_time:, room_number:, status:)
            @guest_name = guest_name
            @start_time = start_time
            @end_time = end_time
            @room_number = room_number
            @status = status
        end

        def available_rooms
            available_rooms = { :@room_number => @status}
            # changes the status of a room from available to unavailable when booked
            first_available_driver[0].status = :UNAVAILABLE
            return 
        end

        def duration (start_time, end_time)

            return
        end
    end
end