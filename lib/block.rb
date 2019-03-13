module HotelSystem
  class Block
    MAX_ROOMS = 5
    attr_reader :rooms, :first_day, :last_day, :discount, :reservations

    def initialize(rooms:, first_day:, last_day:, discount: 0)
      raise ArgumentError, "Blocks can have a max of #{MAX_ROOMS} rooms." if rooms.length > MAX_ROOMS
      @rooms = rooms

      @first_day = first_day
      @last_day = last_day
      @discount = discount
      @reservations = []
      raise ArgumentError, "Not all rooms are available in this Block" unless all_rooms_available?
    end

    def all_rooms_available?
      rooms.each do |room|
        (first_day...last_day).each do |day|
          return false unless room.available?(day)
        end
      end
      return true
    end

    def create_block_reservations
      all_reservations = []
      rooms.each do |room|
        reservation = HotelSystem::BlockReservation.new(room: room, arrive_day: @first_day, depart_day: @last_day, block: self)
        all_reservations << reservation
        room.reservations << reservation
        @reservations << reservation
      end
      return all_reservations
    end

    def find_available_reservations
      availabe_reservations = reservations.select { |res| res.status == :AVAILABLE }
      # availabe_rooms.map! { |res| res.room }
      return availabe_reservations
    end

    # def book_block_reservation(reservation)
    #   raise ArgumentError, "Reservation is Unavailable" if reservation.status == :UNAVAILABLE

    # end
  end
end
