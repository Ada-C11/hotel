# require_relative "spec_helper"
require "date"

class Reservation
  attr_reader :reservation_id, :start_date, :end_date

  def initialize(reservation_id: 0, start_date: nil, end_date: nil)
    @reservation_id = reservation_id
    @start_date = start_date
    @end_date = end_date
  end

  def duration
    duration = (Date.parse(@end_date) - Date.parse(@start_date))
    if duration < 1
      raise ArgumentError, "The duration must be at least one day"
    else
      return duration
    end
  end

  #   def total_cost
  #     cost = duration * 200
  #     return cost
  #   end
end
