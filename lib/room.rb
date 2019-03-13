module Hotel
  class Room
    # add status, and if part of a hotel block; that way a customer can reserve it within a hotel block?
    # alternatively, when reserving room, can have method that checks if room requested is in hotel block
    # for that given date range
    # should each room in hotel block be added as a reservation?

    # adds block object
    attr_reader :id, :cost, :reservations, :block

    def initialize(id:, cost: 200, reservations: nil, block: nil)
      @id = id
      @cost = cost
      @reservations ||= []
      @block ||= []
    end

    def add_reservation(reservation)
      reservations << reservation
    end

    def add_block(hotel_block)
      block << hotel_block
    end
  end
end
