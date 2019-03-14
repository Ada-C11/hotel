require_relative "reservation"
require_relative "room"

module HotelGroup
  class HotelBlock
    attr_reader :discount, :id, :start_time, :end_time, :rooms

    def initialize(id, start_time, end_time, rooms)
      @discount = 0.2
      @id = id
      @start_time = start_time
      @end_time = end_time

      if rooms.count > 5
        raise ArgumentError, "Maximum of 5 rooms allowed in a block"
      end
      rooms.each do |room|
        room.apply_discount(@discount)
        room.add_block_id(@id)
        room.set_unavailable(@start_time, @end_time)
      end
      @rooms = rooms
    end

    def print_nicely(start_time, end_time)
      formatted_rooms = ""
      rooms.each do |room|
        formatted_rooms << "Room #{room.number}: Available = #{room.has_reservation?(start_time, end_time)}, price $#{format("%.2f", room.price)};\n"
      end
      return "For #{start_time} to #{end_time} \nBlock #{id}: \n#{formatted_rooms}"
    end

    def show_unreserved_rooms
      results = []
      rooms.each do |room|
        if !room.has_reservation?(start_time, end_time)
          results << room
        end
      end
      return results
    end
  end
end
