require_relative 'date_range'
require_relative 'room'
require_relative 'hotel_dispatcher'

module Hotel
  class Block
    attr_accessor :start_date, :end_date, :date_range, :rooms, :discounted_rate, :block_reservations
    def initialize(start_date:, end_date:, rooms:, discounted_rate:)
      @date_range = Hotel::DateRange.new(start_date, end_date)
      @rooms = rooms
      @discounted_rate = discounted_rate
      @block_reservations = []
      @rooms.each {|room| room.room_rate = discounted_rate}

      raise ArgumentError.new("A block can contain a maximum of 5 rooms") if @rooms.length > 5 
    end
  end
end