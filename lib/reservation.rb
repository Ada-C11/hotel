require 'date'
require_relative 'room'
require_relative 'date_range'

module HotelManagementSystem
    class Reservation
        attr_reader :start_date, :end_date, :room
        
        def initialize(start_date:, end_date:, room:)
            @start_date = start_date
            @end_date = end_date
            @room = room

            if !HotelManagementSystem::DateRange.is_valid?(start_date, end_date)
                raise ArgumentError, "Reservation can not be created. Invalid date range."
            end

            if room.nil?
                raise ArgumentError, "Reservation can not be created. Room is invalid."
            end

            @room.add_reservation(self)
        end

        def duration
            return (@end_date - @start_date).to_i ### tests for duration
        end

        def total_cost
            return duration * @room.cost ### tests for total_cost
        end
    end
end