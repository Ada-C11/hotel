module Hotel
  class Hotel
    attr_reader :id, :rooms, :reservations

    def initialize(id:, rooms:, reservations: nil)
      @id = id
      @rooms = rooms
      @reservations ||= reservations
    end
  end
end
