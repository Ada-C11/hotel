require 'date'
require_relative 'reservation'

module HotelManagementSystem
    class Block
        attr_reader :start_date, :end_date, :room_collection, :discount_rate

        def initialize(start_date:, end_date:, room_collection: [], discount_rate: 0.8)
            @start_date = Date.parse(start_date.to_s)
            @end_date = Date.parse(end_date.to_s)
            @room_collection = room_collection
            @discount_rate = discount_rate
        end


    end
end
