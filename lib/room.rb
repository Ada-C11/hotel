require 'date'
require_relative 'hotel'
require_relative 'reservation'

module HotelManagementSystem
    class Room
        attr_accessor :room_number, :status, :guest, :cost
        
        COST = 200
        ROOM_NUMBERS = (1..20).to_a
        STATUS = [:AVAILABLE, :UNAVAILABLE]

        def initialize(room_number:, status: :AVAILABLE, guest: nil, cost:)
        @room_number = room_number
        @status = 


        if !STATUS.include?(@status)
            raise ArgumentError, "Invalid status #{@status}."
        end

        if room_number > 20
            raise








        -
    end
end