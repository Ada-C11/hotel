
module Hotel
  class Block
    attr_reader :id, :start_date, :end_date, :rate_discount
    attr_accessor :rooms

    def initialize(id, start_date, end_date, rooms, rate_discount)
      @start_date = start_date
      @end_date = end_date
      @id = id
      @rooms = rooms
      @rate_discount = rate_discount
    end
  end
end
