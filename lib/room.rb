require 'date'
# require_relative 'hotel'
require_relative 'reservation'

module HotelManagementSystem
    class Room
        attr_reader :room_number, :cost, :reservations

        COST = 200

        def initialize(room_number) # this is where you pass in values
            @room_number = room_number
            @cost = COST
            @reservations = []

            if @room_number > 20 || @room_number < 1
                raise ArgumentError, "Invalid room number #{@room_number}."
            end
        end 

        def add_reservation(reservation) # room keeps track of own reservations
            @reservations << reservation
        end
    end
end