module Hotel
  class Room
    attr_accessor :status
    attr_reader :room_number, :rate, :reservations
    
      def initialize(room_number:, status: :AVAILABLE, reservations: [])
        @room_number = room_number
        @status = status
        @reservations = reservations || []
        
          if room_number <= 0 || room_number > 20
            raise ArgumentError, "Room number must be between 1 & 20"
          end
      end
      
      def create_hotel
        @all_rooms = []
        i = 0
        20.times do |i|
          @all_rooms << Hotel::Room.new(room_number: i+1)
        end
        return all_rooms
      end
    
      
      # def is_available?(room_number, date_range)
        
      # end
      
  end
end