module Hotel

  class Reservation
    attr_reader :res_id, :block_id, :room, :cost, :date_span
  
    def initialize(input)
      @res_id = input[:res_id]
      @block_id = input[:block_id].nil? ? nil : input[:block_id]
      @room = input[:room]
      @date_span = input[:date_span]
      @cost = total_cost
    end
  
  def calculate_cost
    num_of_nights = @date_span.stay_length
    cost = @room.cost
  
    reg_cost = (rate * num_of_nights).round(2)
  
    @block_id.nil? ? reg_cost : blocked_cost





    def total_cost
      total_cost = @cost_per_night * @date_span.stay_length
      return total_cost
    end
  end
end
end
