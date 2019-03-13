module Hotel
  class Room
    attr_accessor :status
    attr_reader :room_number, :reservations
    
      def initialize(room_number:, status: :AVAILABLE, reservations: [])
        @room_number = room_number
        @status = status
        @reservations = reservations || []
        
          if room_number <= 0 || room_number > 20
            raise ArgumentError, "Room number must be between 1 & 20"
          end
      end
    
    
      def add_reservation(reservation)
        reservations << reservation
      end
      
      def self.is_available?(date_range)
        self.reservations.each do |reservation|
          reservation.date_range
        end
      end
      
  end
end