require 'date'
require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'

module HotelManagementSystem
    class HotelManager
        attr_reader :reservations

        def initialize
            @reservations = []
            @rooms = []

            1..20.times do |i|
                room = HotelManagementSystem::Room.new(room: i + 1)
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
            
            # assigns first available room to reservation
            room_assignment = list_available_rooms(start_date, end_date).first
            raise ArgumentError, "There is no room available for these dates." if room_assignment == nil

            reservation = HotelManagementSystem::Reservation.new(start_date: start_date, end_date: end_date, room: room_assignment)
            @reservations << reservation
            
            return reservation
        end

        def reservation_cost(reservation)
            return reservation.total_cost
        end

        def list_available_rooms(start_date, end_date)
            dates = start_date..end_date
            res = reservations_by_date(reservations).map { |reservation| reservation.room }
            available_rooms = @rooms - res
            return available_rooms
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
    end
end