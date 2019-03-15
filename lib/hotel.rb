
require_relative "room"
require_relative "reservation"
require_relative "hotelblock"

module HotelGroup
  class Hotel
    attr_accessor :id, :rooms, :reservations, :blocks

    def initialize(directory: "./csv")
      @id = 1
      @rooms = Room.make_rooms_list(20, 200)
      @reservations = Reservation.load_all(directory: directory)
      @blocks = []

      connect_reservations
    end

    def connect_reservations
      reservations.each do |res|
        room = find_room(res.room)
        res.connect(room)
        room.connect(res)
      end

      return reservations
    end

    def find_reservation(id)
      Reservation.validate_id(id)
      return @reservations.find { |res| res.id == id }
    end

    def find_room(id)
      Room.validate_id(id)
      return @rooms.find { |room| room.number == id }
    end

    def list_rooms
      rooms.each do |room|
        return room.print_nicely
      end
    end

    def create_res_id
      return reservations.count + 1
    end

    def create_block_id
      return blocks.count + 1
    end

    def make_reservation(start_time, end_time, room: nil, block: nil)
      if (start_time <=> end_time) == 1
        raise ArgumentError, "End time must be later than start time"
      end

      if room && (!room.is_available?(start_time, end_time) && !block)
        raise ArgumentError, "Room #{room.number} is unavailable"
      end

      room ||= find_available_rooms(start_time, end_time)[0]

      reservation = Reservation.new(create_res_id, start_time, end_time, room)

      room.add_reservation(reservation)
      reservations << reservation
      if block
        blocks << block
      end
    end

    def find_by_date(date)
      matching_reservations = []

      reservations.each do |res|
        if res.includes_date?(date)
          matching_reservations << res
        end
      end

      return matching_reservations
    end

    def find_available_rooms(start_time, end_time)
      available_rooms = []
      rooms.each do |room|
        if room.is_available?(start_time, end_time)
          available_rooms << room
        end
      end

      return available_rooms
    end

    def create_hotel_block(id, start_time, end_time, rooms)
      id = create_block_id

      rooms.each do |room|
        if !room.is_available?(start_time, end_time)
          raise ArgumentError, "Room #{room.number} is not available on the given dates:#{start_time} #{end_time}"
        end
      end
      hotel_block = HotelBlock.new(id, start_time, end_time, rooms)

      return hotel_block
    end

    def reserve_block_room(room, block)
      if !room.is_in_block?(block)
        raise ArgumentError, "Room #{room.number} is not in block #{block.id}"
      end

      if (room.has_reservation?(block.start_time, block.end_time))
        raise ArgumentError, "Room #{room.number} is already reserved"
      end

      make_reservation(block.start_time, block.end_time, room: room, block: block)
    end
  end
end
