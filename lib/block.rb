module HotelSystem
  class Block
    attr_reader :rooms, :first_day, :last_day, :discount

    def initialize(rooms:, first_day:, last_day:, discount: 0)
      @rooms = rooms
      @first_day = first_day
      @last_day = last_day
      @discount = discount
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

    def create_reservations
      all_reservations = []
      rooms.each do |room|
        reservation = HotelSystem::Reservation.new(room: room, arrive_day: @first_day, depart_day: @last_day)
        all_reservations << reservation
        room.reservations << reservation
      end
      return all_reservations
    end
  end
end
