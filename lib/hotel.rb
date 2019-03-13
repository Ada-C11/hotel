require 'date'
require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'

module HotelManagementSystem
    class HotelManager
#         attr_accessor :guest, :status
#         COST = 200
#         ROOM_NUMBERS = (1..20).to_a
#         STATUS = [:AVAILABLE, :UNAVAILABLE]

        def initialize()
            @reservations = []
        end

        def list_rooms
            return
        end

        def reserve(start_date, end_date)
            if !HotelManagementSystem::DateRange.is_valid?(start_date, end_date)
                raise ArgumentError, "You have entered an invalid date range."
            end
            room = "hey"
            reservation = HotelManagementSystem::Reservation.new(start_date, end_date, room)
            @reservations << reservation
            return reservation
        end

        def reservations_by_date(date)
            return
        end

        def reservation_cost(reservation)
            return reservation.total_cost
        end
    end
end