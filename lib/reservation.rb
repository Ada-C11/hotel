module HotelSystem
  class Reservation
    attr_reader :room, :date_range, :total_cost

    def initialize(room:, arrive_day:, depart_day:)
      @room = room
      @arrive_day = arrive_day
      @depart_day = depart_day
      @date_range = (arrive_day...depart_day)
    end

    def calc_total_cost
      nights_stayed = 0
      @date_range.each { nights_stayed += 1 }
      @total_cost = nights_stayed * @room.price_per_night
      return total_cost
    end
  end
end
