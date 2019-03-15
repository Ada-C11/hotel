require_relative "reservation"
require_relative "room"
require_relative "csv_record"
require_relative "hotel"

module HotelGroup
  class HotelBlock < CsvRecord
    attr_reader :discount, :id, :start_time, :end_time, :rooms

    def initialize(id, start_time, end_time, rooms, discount)
      @discount = discount
      @id = id
      @start_time = start_time
      @end_time = end_time

      if rooms.count > 5
        raise ArgumentError, "Maximum of 5 rooms allowed in a block"
      end

      @rooms = rooms
    end

    def connect(rooms_array)
      rooms_array.each.with_index do |room, index|
        @rooms[index] = room
      end
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

    private

    def self.from_csv(record)
      rooms = record[:rooms].split(";")
      rooms.each do |r|
        r.to_i
      end

      return self.new(
               record[:id],
               Date.parse(record[:start_date]),
               Date.parse(record[:end_date]),
               rooms,
               record[:discount]
             )
    end
  end
end
