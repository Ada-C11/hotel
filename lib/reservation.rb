module Hotel
  class Reservation
    attr_reader :id, :check_in, :check_out, :room, :cost

    def initialize(id:, check_in:, check_out:, cost: 200, hotel_block: nil)
      @check_in = Date.parse(check_in)

      @check_out = Date.parse(check_out)

      if !@check_out.nil? && @check_out < @check_in
        raise ArgumentError.new("Check-out date before check-in date")
      end
      @cost = cost
      # @hotel_block = hotel_block
      @id = id
    end

    def duration
      duration = (check_out - check_in).to_i
      return duration
    end

    def self.date(start)
      # takes in start and end time reservation
      # parses through date using date object
    end
  end
end
