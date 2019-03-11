require_relative 'room'
require_relative 'reservation'
require_relative 'reservation_block'


module Hotel
    class Hotel_ledger
        attr_reader :rooms, :reservations, :reservation_blocks

        def initialize(date)
            @rooms = Room.list_all(date)
            @reservations = Reservation.list_all(date)
            @reservation_blocks = Reservation_block.list_all(date)
        end
        
        private

        def self.list_all(date)
            return 
          end
    end
end