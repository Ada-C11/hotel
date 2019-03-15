
require "date"

require_relative "csv_record"
require_relative "room"

module HotelGroup
  class Reservation < CsvRecord
    attr_accessor :id, :room, :start_time, :end_time

    def initialize(id, start_time, end_time, room)
      @start_time = start_time
      @end_time = end_time
      @room = room
      @id = id
    end

    def total_price
      number_of_days = end_time - start_time
      return format("%.2f", room.price * number_of_days)
    end

    def includes_date?(date)
      return start_time <= date && end_time >= date ? true : false
    end

    def print_nicely
      return "Reservation #{id}: Room #{room.number} from #{start_time} to #{end_time}. Total cost: $#{total_price}"
    end

    def connect(room)
      @room = room
      return self
    end

    private

    def self.from_csv(record)
      return self.new(
               record[:id],
               Date.parse(record[:start_date]),
               Date.parse(record[:end_date]),
               record[:room],
             )
    end

    def self.save(full_path, all_reservations)
      CSV.open(full_path, "w") do |file|
        header_row = ["id", "start_date", "end_date", "room"]
        file << header_row
        all_reservations.each do |r|
          start_date = "#{r.start_time.year}-#{r.start_time.month}-#{r.start_time.day}"

          end_date = "#{r.end_time.year}-#{r.end_time.month}-#{r.end_time.day}"

          room_string = "#{r.room.number}"

          new_line = ["#{r.id}", "#{start_date}", "#{end_date}", "#{room_string}"]
          file << new_line
        end
      end
    end
  end
end
