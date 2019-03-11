require 'date'
require_relative 'hotel'
require_relative 'room'

module HotelManagementSystem
    class Reservation
        attr_accessor :guest, :start_time, :end_time, :duration, :room_number

        def initialize(id)
            self.class.validate_id(id)
            @id = id
        end


        def reserve
            # changes the status of a room from available to unavailable when booked
            return 
        end




-


    end
end