require 'date'
require_relative 'reservation'

module HotelManagementSystem
    class Room
        attr_reader :room, :reservations

        def initialize(room:)
            @room = room
            @reservations = []

            if @room > 20 || @room < 1
                raise ArgumentError, "Invalid room number #{@room}."
            end
        end 

        def add_reservation(reservation)
            @reservations << reservation
        end
    end
end