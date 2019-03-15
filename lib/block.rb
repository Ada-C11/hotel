require_relative 'date_range'
require_relative 'reservation'

class Block 
  attr_accessor :date_range, :check_out, :number_of_rooms, :rooms, :discount_rate

  def initialize(check_in:, check_out:, number_of_rooms:, rooms: [], discount_rate:)
    @date_range = DateRange.generate_date_range(check_in, check_out)
    @number_of_rooms = number_of_rooms
    @rooms = rooms
    @discount_rate = discount_rate
  end
end