require_relative "reservation"
require_relative "room"
require_relative "csv_record"
require_relative "hotel"

module HotelGroup
  class HotelBlock < CsvRecord
    attr_reader :discount, :id, :start_time, :end_time

    attr_accessor :rooms

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
        room.add_block_id(@id)
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
      final_rooms = []
      rooms.each do |r|
        final_rooms << r.to_i
      end

      return self.new(
               record[:id],
               Date.parse(record[:start_date]),
               Date.parse(record[:end_date]),
               final_rooms,
               record[:discount]
             )
    end

    def self.save(full_path, all_blocks)
      CSV.open(full_path, "w") do |file|
        header_row = ["id", "start_date", "end_date", "rooms", "discount"]
        file << header_row
        all_blocks.each do |b|
          start_date = "#{b.start_time.year}-#{b.start_time.month}-#{b.start_time.day}"

          end_date = "#{b.end_time.year}-#{b.end_time.month}-#{b.end_time.day}"

          room_string = ""
          b.rooms.each do |r|
            room_string << "#{r.number}:"
          end

          new_line = ["#{b.id}", "#{start_date}", "#{end_date}", "#{room_string.chomp}", "#{b.discount}"]
          file << new_line
        end
      end
    end
  end
end
