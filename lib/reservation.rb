require 'date'
require_relative 'room'
require_relative 'date_range'

module HotelManagementSystem
    class Reservation
        attr_reader :start_date, :end_date, :room
        
        def initialize(start_date:, end_date:, room: nil)
            @start_date = Date.parse(start_date.to_s)
            @end_date = Date.parse(end_date.to_s)
            @room = room

            if !HotelManagementSystem::DateRange.is_valid?(start_date, end_date)
                raise ArgumentError, "Reservation can not be created. Invalid date range."
            end

            if room.nil?
                raise ArgumentError, "Reservation can not be created. Room is invalid."
            end

            room.add_reservation(self) # add reservation to list of reservations
        end

        def duration
            return (@end_date - @start_date).to_i
        end

        def total_cost
            return duration * @room.cost
        end
    end
end