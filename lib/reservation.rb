require "time"
require "date"

require_relative "room"

class Reservation
  attr_accessor :id, :room, :start_time, :end_time, :total_price

  def initialize(id, start_time, end_time)
    @start_time = start_time
    @end_time = end_time
    @id = id
    @total_price = find_total_price
  end
end
