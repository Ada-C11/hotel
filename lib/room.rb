require "csv"

module Hotel
  class Room
    # attr_reader :room_id
    attr_accessor :room_id, :cost

    def initialize(room_id:, cost: self.class.cost)
      @room_id = room_id
      @cost = cost
    end

    def self.cost
      return 200.00
    end

    def self.num_rooms
      return 20
    end

    # def self.load_all
    #   @all_rooms = []
    #   self.num_rooms.times do |id|
    #     room = self.new(id + 1, cost: self.cost)
    #     @all_rooms << room
    #   end
    #   return @all_rooms
    # end

    # @all_rooms = []

    # read rooms' data from rooms.csv
    # ROOM_DATA_DIRECTORY = "support/rooms.csv"
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
