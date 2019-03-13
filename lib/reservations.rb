require 'datespans.rb'

module Hotel

  class Reservation
    attr_reader :res_id, :rm_id, :cost, :check_in, :check_out

    def initialize(input)
      @res_id = input[:res_id]
      @room = input[:rm_id]
      @span = Date_Span.new(input[:check_in], input[:check_out])
      @cost = total_cost
    end

    def total_cost
      total_cost = room.cost * @span.stay_length
      total_cost
    end
  end
end
