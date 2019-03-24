require "csv"

module Hotel
  class Room
    # using attr_accessor to allow the user to set different rates for rooms
    attr_accessor :room_id, :cost

    def initialize(room_id:, cost: self.class.cost)
      @room_id = room_id
      @cost = cost
    end

    # make it a class so that it's easy to generate data into CSV files
    def self.cost
      return 200.00
    end

    def self.num_rooms
      return 20
    end

    def self.load_all
      return CSV.read(
               "support/rooms.csv",
               headers: true,
               header_converters: :symbol,
               converters: :numeric,
             ).map { |record| self.from_csv(record) }
    end

    def self.from_csv(record)
      return new(
               room_id: record[:room_id],
               cost: record[:cost],
             )
    end
  end
end
