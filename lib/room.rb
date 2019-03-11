module Hotel
  class Room
    attr_accessor :status
    attr_reader :room_number, :rate, :reservations
    
      def initialize(room_number:, rate: 200, status: :AVAILABLE, reservations: [])
        @room_number = room_number
        @rate = rate
        @status = status
        @reservations = reservations || []
        
          if room_number <= 0 || room_number > 20
            raise ArgumentError, "Room number must be between 1 & 20"
          end
      end
      
      def is_available?(room_number, date_range)
        
      end
      
  end
end