require 'date'
require_relative 'date_range'
require_relative 'room'

module Hotel 
  class Reservation
    attr_reader :start_date, :end_date, :date_range
    attr_accessor :room, :total_cost
    def initialize (start_date:, end_date:, room: nil)
      @date_range = Hotel::DateRange.new(start_date, end_date)
      @room = room
      @total_cost = self.calculate_cost
    end

    def calculate_cost
      @total_cost = @date_range.date_count * @room.cost_per_night
      return total_cost.to_i
    end
  end 
end