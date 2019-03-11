module HotelSystem
  class Reservation
    attr_reader :room, :date_range

    def initialize(room:, arrive_day:, depart_day:)
      @room = room
      @arrive_day = arrive_day
      @depart_day = depart_day
      @date_range = (arrive_day..depart_day)
      # puts "#{range}"
      # range.each { |date| puts date }
    end
  end
end
