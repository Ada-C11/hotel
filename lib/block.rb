require 'date'
require_relative 'reservation'

module HotelManagementSystem
    class Block
        attr_reader :start_date, :end_date, :room_collection, :discount_rate

        def initialize(start_date:, end_date:, room_collection:)
            @start_date = start_date
            @end_date = end_date
            @room_collection = room_collection
        end

        def total_cost
            return (end_date - start_date) * (@rooms.cost) * (number_of_rooms) * (discount_rate)
        end
    end
end
