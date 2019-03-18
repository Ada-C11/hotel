require "date"


module HotelSystem
  class Block
    attr_reader :start_date, :end_date, :room_collection, :id, :discount_rate
    attr_accessor :reservations

    def initialize(start_date:, end_date:, room_collection:)
      @start_date = start_date
      @end_date = end_date
      @room_collection = room_collection
      @reservations = []
      @id = ((0...5).map { rand(10) }).join.to_s
      @discount_rate = 0.22

      room_collection_blockable?(room_collection)
      raise ArgumentError, "Must enter at least 2 rooms. 5 max" if room_collection.length < 2 || room_collection.length > 5
    end

    def room_collection_blockable?(room_collection)
      @room_collection.each do |room|
        raise ArgumentError, "One of the rooms you entered is already reserved during the specified dates" if !room.date_available?(@start_date, @end_date)
      end
    end

    def room_still_available?
      if @reservations.length < @room_collection.length
        return true
      else
        return false
      end
    end
  end
end
