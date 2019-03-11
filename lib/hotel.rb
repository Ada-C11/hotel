module HotelSystem
  class Hotel
    attr_reader :reservations, :blocks
    attr_accessor :rooms

    def initialize(id:, rooms: [], reservations: [], blocks: [])
      @id = id
      @rooms = rooms
      @reservations = reservations
      @blocks = blocks
    end

    def list_rooms
      room_list = @rooms.map { |room| room.id }
      # return nil if rooms.length == 0
      return room_list
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def make_reservation(room, arrive_day, depart_day)
      reservation = HotelSystem::Reservation.new(room: room, arrive_day: arrive_day, depart_day: depart_day)
      add_reservation(reservation)
      room.add_reservation(reservation)
    end

    def reservations_by_date(date)
      reservations = @reservations.select { |res| res.date_range.include?(date) }
      return reservations
    end
  end
end
