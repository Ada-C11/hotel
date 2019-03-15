module HotelSystem
  class BlockReservation < HotelSystem::Reservation
    attr_reader :block, :status, :discount

    def initialize(room:, arrive_day:, depart_day:, block:, status: "AVAILABLE", discount: 0)
      super(room: room, arrive_day: arrive_day, depart_day: depart_day)
      @block = block
      @status = status.to_sym
      @discount = discount
      @date_range = (arrive_day...depart_day)
    end

    def book_reservation
      @status = :UNAVAILABLE
    end

    def calc_total_cost
      total = super
      total_with_discount = (total - (total * discount)).round(2)
      @total_cost = total_with_discount
      return total_with_discount
    end
  end
end
