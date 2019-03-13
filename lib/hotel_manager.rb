require 'date'
require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'

module HotelManagementSystem
    class HotelManager
        # attr_reader :reservations # need to access for tests 

        def initialize
            @reservations = []
            @rooms = []

            1..20.times do |i|
                room = HotelManagementSystem::Room.new(i + 1)
                @rooms << room
            end
        end

        def list_rooms
            return @rooms
        end

        def reserve(start_date, end_date)
            if !HotelManagementSystem::DateRange.is_valid?(start_date, end_date)
                raise ArgumentError, "You have entered an invalid date range."
            end
            
            # assign a room that is available, this just assigns any room
            room = @rooms.sample
            reservation = HotelManagementSystem::Reservation.new(start_date, end_date, room)
            @reservations << reservation
            
            return reservation
        end

        def reservations_by_date(requested_date)
            reservations_by_date = []
            @reservations.each do |reservation|
                if HotelManagementSystem::DateRange.within_range?(reservation.start_date, reservation.end_date, requested_date)
                    reservations_by_date << reservation
                end
            end
            
            return reservations_by_date
        end

        def reservation_cost(reservation)
            return reservation.total_cost
        end
    end
end