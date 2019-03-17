
module Hotel
  class Block
    attr_reader :start_date, :end_date, :rooms, :rate_discount

    def initialize(start_date, end_date, rooms, rate_discount)
      @start_date = start_date
      @end_date = end_date
      @rooms = rooms
      @rate_discount = rate_discount
    end
  end
end
