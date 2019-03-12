module HotelSystem
  class Hotel
    attr_reader :reservations, :blocks
    attr_accessor :rooms

    def initialize(id:, rooms: [], reservations: [], blocks: [])
      @id = id
      @rooms = rooms
      @reservations = reservations
      @blocks = blocks
    end

    def list_rooms
      room_list = @rooms.map { |room| room.id }
      # return nil if rooms.length == 0
      return room_list
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def create_date_object(date)
      date_object = Date.parse(date)
      return date_object
    end

    def make_reservation(room, first_day, last_day)
      arrive_day = create_date_object(first_day)
      depart_day = create_date_object(last_day)
      # arrive_day = first_day
      # depart_day = last_day

      reservation = HotelSystem::Reservation.new(room: room, arrive_day: arrive_day, depart_day: depart_day)
      add_reservation(reservation)
      room.add_reservation(reservation)
    end

    # def create_date_object(date)
    #   date_object = Date.parse(date)
    # end

    def reservations_by_date(date)
      date_object = create_date_object(date)
      reservations = @reservations.select { |res| res.date_range.include?(date_object) }
      return reservations
    end

    # def select_avalible_rooms(rooms, date)
    #   available_rooms = rooms.select { |room| room.available?(date) == true }
    #   return available_rooms
    # end

    def available_rooms_by_date_range(first_day, last_day)
      arrive_day = create_date_object(first_day)
      depart_day = create_date_object(last_day)
      available_rooms = @rooms.clone
      (first_day...last_day).each do |day|
        date = create_date_object(day)
        available_rooms = available_rooms.select { |room| room.available?(date) == true }
      end
      return available_rooms
    end
  end
end
