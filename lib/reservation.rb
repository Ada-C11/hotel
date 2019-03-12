require "date"

class Reservation
  attr_reader :id, :room_id, :start_date, :end_date, :dates

  def initialize(id, room_id, start_date, end_date)
    @id = id
    @start_date = start_date
    @end_date = end_date
    @room_id = room_id
    if @start_date > @end_date
      raise ArgumentError, "start_date must be before end_date"
    end
    # @dates = []
  end
end
