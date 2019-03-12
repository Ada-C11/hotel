require 'date'
require_relative 'date_range'

class Reservation < DateRange
  attr_reader :id, :start_date, :end_date, :room_booked, :total_cost

  def initialize id:nil, start_date:, end_date:, room_booked: nil
    valid_id(id)
    valid_date?(start_date)
    valid_date?(end_date)
    date_range_valid?(start_date, end_date)

    @id = id
    @start_date = start_date
    @end_date = end_date
    @room_booked = room_booked
    @total_cost = total_cost
  end

  def self.make_reservation(reservation)
    @reservations = []
    @reservations << reservation
  end

  def self.all_rooms
    return @Room.all_rooms
  end

  def valid_id(id)
    unless id.instance_of?(Integer) && id > 0 && id <= 20
      raise ArgumentError, "ID must be a positive number, given #{id}..."
    end
  end

  def  valid_date?(date)
    super
  end

  def date_range_valid?(check_in, check_out)
    super
  end

  def total_cost
  end
  

  private
  
end

