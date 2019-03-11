module Hotel
  class Reservation
    attr_reader :id, :start_date, :end_date, :room

    def initialize(id:, start_date:, end_date:, room:)
      @id = id
      @start_date = start_date
      @end_date = end_date
      @room = room
    end
  end
end
