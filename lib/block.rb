
module Hotel
  class Block < Hotel::Reservation
    attr_reader :start_date, :end_date, :rooms, :rate_discount

    def initialize(start_date, end_date, rooms, rate_discount)
      validate_date_range(start_date, end_date)
      @rooms = rooms
      @rate_discount = rate_discount
    end
  end
end
