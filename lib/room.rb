module Hotel
  class Room
    attr_accessor :status
    attr_reader :id, :reservation, :rooms

    STATUS = [:VACANT, :OCCUPIED]

    def initialize(id:, status: :VACANT, rooms: [])
      @id = id
      @status = status.to_sym
      @rooms = []

      if !STATUS.include?(@status)
        raise ArgumentError, "Invalid status #{@status}."
      end
    end

    def add_room(room)
      @rooms << indiv_room
    end
  end
end
