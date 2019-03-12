require 'date'

module HotelSystem
  class Reservation
    attr_reader :reservation_id, :room_number, :start_date, :end_date, :total, :guest
    
    def initialize(room_number:,
      start_date:, 
      end_date:, 
      total: nil, 
      guest:)
      @reservation_id = (0...5).map { rand(10) }
      @room_number = room_number
      start_date = start_date.to_s
      @start_date = Date.parse(start_date)
      end_date = end_date.to_s
      @end_date = Date.parse(end_date)
      @total = nil
      @guest = guest
    end

    def calculate_cost
    end

    def find_available_room
    end
  end
end