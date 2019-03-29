require_relative "reservation"
require_relative "csv_record"

module HotelGroup
  class Room < CsvRecord
    attr_accessor :number, :price, :reservations, :unavailable_dates, :blocks, :block_price

    def initialize(number, price)
      @number = number
      @price = price
      @block_price = price * 0.8
      @reservations = []
      @blocks = []
    end

    # def self.make_rooms_list(number, price)
    #   rooms = []
    #   number.times do |n|
    #     room = Room.new(n + 1, price)

    #     rooms << room
    #   end
    #   return rooms
    # end

    def connect(res)
      reservations << res
      return self
    end

    def add_reservation(res)
      reservations << res
    end

    def is_available?(start_time, end_time)
      if blocks == [] && reservations == []
        return true
      end
      blocks.each do |block|
        return false if block.overlap?(start_time, end_time)
      end
      return false if has_reservation?(start_time, end_time)

      return true
    end

    def add_block(block)
      @blocks << block
      return self
    end

    def has_reservation?(start_time, end_time)
      if reservations.count == 0
        return false
      end
      reservations.each do |res|
        if res.overlap?(start_time, end_time)
          return true
        end
      end
      return false
    end

    def is_in_block?(block)
      blocks.each do |block_obj|
        if block_obj.id == block.id
          return true
        end
      end
      return false
    end

    def print_nicely
      return "Room #{number}: $#{format("%.2f", price)} per night"
    end

    private

    def self.from_csv(record)
      return self.new(
               record[:number],
               record[:price],
             )
    end
  end
end
