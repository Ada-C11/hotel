module HotelSystem
  class BlockReservation < HotelSystem::Reservation
    attr_reader :block, :status

    def initialize(room:, arrive_day:, depart_day:, block:, status: "AVAILABLE")
      super(room: room, arrive_day: arrive_day, depart_day: depart_day)
      @block = block
      @status = status.to_sym
    end
  end
end
