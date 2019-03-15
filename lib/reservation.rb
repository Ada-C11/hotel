module Hotel
  class Reservation
    attr_reader :id, :start_date, :end_date, :room, :total_cost

    def initialize(id:, start_date:, end_date:, room:, total_cost: nil)
      @id = id
      @start_date = start_date
      @end_date = end_date
      raise ArgumentError if end_date <= start_date
      @room = room
      @total_cost = calc_total_cost
    end

    def calc_total_cost
      return (end_date - start_date).to_i * room.cost
    end
  end
end
