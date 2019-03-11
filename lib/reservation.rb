module HotelSystem
  class Reservation
    attr_reader :room

    def initialize(room:, arrive_day:, depart_day:)
      @room = room
      @arrive_day = arrive_day
      @depart_day = depart_day
    end
  end
end
