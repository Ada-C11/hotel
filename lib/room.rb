require 'date'
# require_relative 'hotel'
require_relative 'reservation'

module HotelManagementSystem
    class Room
        attr_reader :room_number, :start_date, :end_date
        attr_accessor :status
        
        ROOM_NUMBER = (1..20).to_a
        STATUS = [:AVAILABLE, :UNAVAILABLE]

        def initialize(room_number:, start_date:, end_date:, status: :AVAILABLE)
            @room_number = room_number
            @status = status.to_sym
            @start_date = start_date
            @end_date = end_date

            if !STATUS.include?(@status)
                raise ArgumentError, "Invalid status #{@status}."
            end

            if @room_number > 20 || @room_number < 1
                raise ArgumentError, "Invalid room number #{@room_number}."
            end
        end 

        def reserved_dates
            reserved_dates = []
            reserved_dates << 

    end

end