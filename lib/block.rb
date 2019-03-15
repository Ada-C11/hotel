require "date"

module HotelSystem
  class Block
    attr_reader :start_date, :end_date, :room_collection, :block_id, :price_per_room, :discount_rate, :reservations

    def initialize(start_date:, end_date:, room_collection:)
      @start_date = start_date
      @end_date = end_date
      @room_collection = room_collection
      @reservations = []
      @block_id = ((0...5).map { rand(10) }).join.to_s
      @price_per_room = 200
      @discount_rate = 0.22

      raise ArgumentError, "Must enter at least 2 rooms. 5 max" if room_collection.length < 2 || room_collection.length > 5
    end

    def room_available?
      if @reservations.length < @room_collection.length
        return true
      else
        return false
      end
    end
  end
end
