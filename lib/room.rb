module Hotel
  class Room
    attr_reader :rate
    attr_accessor :status

    def initialize(room_number:, status: :AVAILABLE)
      @rate = 200
      @status = status
      @number = room_number
    end

    def available?
      status == :AVAILABLE ? true : false
    end
  end
end
