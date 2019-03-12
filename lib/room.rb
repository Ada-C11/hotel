module Hotel
  class Room
    attr_reader :room_num, :cost_per_night, :status
    def initialize(room_num:, cost_per_night: 200, status: :AVAILABLE)
      @room_num = room_num
      @cost_per_night = cost_per_night
      @status = status

      raise ArgumentError.new("Invalid room number") if @room_num < 1 || @room_num > 20
    end
  end
end