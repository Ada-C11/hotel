require_relative "reservation"
require "date"

module Hotel
    class Room
        attr_reader :id

        attr_accessor :reservations

        def initialize(id:)
            @id = id
            @reservations = []
        end

        def available?(date)
            desired_date = Date.iso8601(date.to_s)
            reserved_dates = @reservations.map{|reservation| reservation.date_range}.flatten
            reserved_dates.include?(desired_date) == true ? status = false : status = true
            return status
        end

        def self.load_rooms
            rooms = []
            20.times do |i|
                rooms.push(Hotel::Room.new(id: i+1))
            end
            return rooms
        end
        

    end
end