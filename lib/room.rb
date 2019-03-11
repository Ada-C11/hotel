require 'date'
require_relative 'hotel'
require_relative 'reservation'

module HotelManagementSystem
    class Room
        attr_reader :cost
        attr_accessor :guest, :status, :room_number
        
        ROOM_NUMBER = (1..20).to_a
        STATUS = [:AVAILABLE, :UNAVAILABLE]
        COST = 200

        def initialize(room_number:, status: :AVAILABLE, guest: nil, cost: COST)
            @room_number = room_number
            @status = status.to_sym
            @guest = guest
            @cost = COST


            if !STATUS.include?(@status)
                raise ArgumentError, "Invalid status #{@status}."
            end

            if @room_number > 20 || @room_number < 1
                raise ArgumentError, "Invalid room number #{@room_number}."
            end
        end 

    end

end