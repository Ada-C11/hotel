module HotelSystem
  class Reservation
    attr_reader :room, :date_range, :total_cost, :arrive_day, :depart_day

    def initialize(room:, arrive_day:, depart_day:)
      raise ArgumentError if depart_day <= arrive_day
      @room = room
      @arrive_day = arrive_day
      @depart_day = depart_day
      @date_range = (arrive_day...depart_day)
    end

    def price_per_night
      return room.price_per_night
    end

    def calc_total_cost
      nights_stayed = 0
      date_range.each { nights_stayed += 1 }
      @total_cost = nights_stayed * price_per_night
      return total_cost
    end

    def include?(date_object)
      return date_range.include?(date_object)
    end
  end
end
