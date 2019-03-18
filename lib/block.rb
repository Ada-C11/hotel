
module Hotel
  class Block
    attr_reader :id, :start_date, :end_date, :rate_discount
    attr_accessor :room

    def initialize(id, start_date, end_date, room, rate_discount)
      @start_date = start_date
      @end_date = end_date
      @id = id
      @room = room
      @rate_discount = rate_discount
    end
  end
end
