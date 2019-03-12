module Hotel
  class Room

    STATUS = [:AVAILABLE, :UNAVAILABLE]
    COST = 200.00

    attr_reader :room_number, :cost
    attr_accessor :status, :available_rooms, :unavailable_rooms

    def initialize(room_number:, status: :AVAILABLE)
      @room_number = room_number
      @status = :AVAILABLE.to_sym
      @cost = COST
      
    end

    def is_available?(data_range)


    end
  end # Class end
end # Module end