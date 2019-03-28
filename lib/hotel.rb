
require_relative "room"
require_relative "reservation"
require_relative "hotelblock"

module HotelGroup
  class Hotel
    attr_accessor :id, :rooms, :reservations, :blocks

    def initialize(directory: "./csv")
      @id = 1
      @rooms = Room.load_all(directory: directory)
      @reservations = Reservation.load_all(directory: directory)
      @blocks = HotelBlock.load_all(directory: directory)

      connect_reservations
      connect_blocks
    end

    def connect_blocks
      blocks.each do |block|
        room_array = []
        block.rooms.each do |room_id|
          room_obj = find_room(room_id)
          room_array << room_obj
          room_obj.add_block_id(block.id)
          room_obj.block_price = room_obj.price - room_obj.price * block.discount
        end
        block.rooms = room_array
      end
      return blocks
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
        puts room.print_nicely
      end
    end

    def list_blocks
      blocks.each do |block|
        puts block.print_nicely
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

      if room && !@rooms.include?(room)
        raise ArgumentError, "Invalid room"
      end

      if room && (!room.is_available?(start_time, end_time) && !block)
        raise ArgumentError, "Room #{room.number} is unavailable"
      end

      room ||= find_available_rooms(start_time, end_time)[0]

      if !room
        raise ArgumentError, "No vacancy for the specified dates"
      end

      reservation = Reservation.new(create_res_id, start_time, end_time, room)

      room.add_reservation(reservation)

      if block
        reservation.block_reservation = true
        blocks << block
      end
      reservations << reservation
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

    def create_hotel_block(start_time, end_time, rooms, discount: nil)
      id ||= create_block_id
      discount ||= 0.2
      rooms_array = []
      rooms.each do |room_id|
        room = find_room(room_id)

        if !room.is_available?(start_time, end_time)
          raise ArgumentError, "Room #{room.number} is not available on the given dates:#{start_time} #{end_time}"
        end

        room.add_block_id(id)

        room.set_unavailable(start_time, end_time)
        rooms_array << room
      end
      hotel_block = HotelBlock.new(id, start_time, end_time, rooms_array, discount)

      @blocks << hotel_block

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
