module Hotel
  class Room

    attr_reader :id, :cost, :reservations, :blocks

    def initialize(id, cost)
      @id = id
      @cost = cost
      @reservations = []
      @blocks = []
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def add_block(block)
      @blocks << block
    end

    def is_available?(checkin, checkout)
      dates = Hotel::Reservation.reservation_dates(checkin, checkout)
      @reservations.each do |res|
        dates.each do |date|
          return false if res.includes_date?(date)
        end
      end
      @blocks.each do |block|
        dates.each do |date|
          return false if block.includes_date?(date)
        end
      end
      return true
    end

    def self.list_rooms(starting_id, num_rooms, cost)
      rooms = []
      num_rooms.times do
        rooms << Room.new(starting_id, cost)
        starting_id += 1
      end
      return rooms
    end
  end
end