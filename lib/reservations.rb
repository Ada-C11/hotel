require "room_factory.rb"
require "datespans.rb"

module Hotel
  class Reservation
    attr_reader :id, :rm_id, :total, :check_in, :check_out

    def initialize(**input)
      @id = input[:id]
      @room = input[:room]
      @span = DateSpan.new(input[:check_in], input[:check_out])
      @cost = COST
      @total = total_cost
    end

    def total_cost
      total = @cost * @span.stay_length
      total
    end
  end
end
