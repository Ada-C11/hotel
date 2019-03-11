module Hotel
  class Room
    attr_accessor :status
    attr_reader :room_number, :rate
    
      def initialize(room_number:, rate: 200, status: :AVAILABLE)
        @room_number = room_number
        @rate = rate
        @status = status
      end
  end
end