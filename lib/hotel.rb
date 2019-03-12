module Hotel
  class Hotel
    attr_reader :id, :rooms, :reservations

    def initialize(id:, rooms:, reservations: nil)
      @id = id
      @rooms = rooms
      @reservations ||= reservations
    end

    def reserve_room(id, start_date, end_date, room_id)
      #check if room available during those days
      rooms_available = available_rooms(start_date, end_date)
      raise ArgumentError if !(rooms_available.include?(room_id))
      # find room object with room ID
      room = find_room(room_id)
      #
      return Reservation.new(id: id, start_date: start_date, end_date: end_date, room: room)
    end

    def find_room(room_ID)
      @rooms.detect { |room| room.id == room_ID }
    end

    def add_reservation(reservation)
      reservations << reservation
    end

    def access_reservations(date)
      list_reservations = @reservations.select { |reservation| (Range.new(reservation.start_date, reservation.end_date)).include?(date) }
      return list_reservations.map { |reservation| reservation.id }
    end

    def available_rooms(start_date, end_date)
      avail_rooms = []
      @rooms.each do |room|
        if room.reservations == []
          avail_rooms << room
        else
          check_avail = room.reservations.select do |reservation|
            !(reservation.start_date...reservation.end_date).include?(start_date) &&
            !(reservation.start_date..reservation.end_date).include?(end_date)
          end
          #   p "#{room.id}: #{check_avail}"
          avail_rooms << room if check_avail.length > 0
        end
      end
      return avail_rooms.map { |room| room.id }
    end
  end
end
