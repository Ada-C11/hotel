module Hotel
  class Room
    attr_accessor :status
    attr_reader :room_number, :reservations
    
      def initialize(room_number:, status: :AVAILABLE, reservations: [])
        @room_number = room_number
        @status = status
        @reservations = []
        
          if room_number <= 0 || room_number > 20
            raise ArgumentError, "Room number must be between 1 & 20"
          end
      end
    
    
      def add_reservation(reservation)
        @reservations << reservation
      end
      
      def is_available?(date_range)
        return false if @reservations.each { |res| res.overlap_date_range?(date_range) } 
        
      end
      
  end
end