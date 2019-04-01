require_relative "room.rb"
require_relative "reservation.rb"
require_relative "block.rb"

module Hotel
  class HotelManager
    attr_reader :rooms, :reservations, :blocks

    def initialize(rooms)
      @rooms = rooms
      @reservations = []
      @blocks = []
    end

    #reservation methods
    def make_reservation(room_number, start_date, end_date)
      room = find_room_by_number(room_number)
      if self.list_available_rooms(start_date, end_date).include?(room)
        new_reservation = Hotel::Reservation.new(room: room, start_date: start_date, end_date: end_date)
        @reservations.push(new_reservation)
        return new_reservation
      else
        raise ArgumentError, "Room #{room_number} is unavailable. Must use an available room."
      end
    end

    def list_reservations_by_date(date)
      date = Date.parse(date)
      found_reservations = @reservations.select { |reservation| reservation.includes?(date) }
      return found_reservations
    end

    #block methods
    def make_block(room_numbers, start_date, end_date, discount_rate)
      start_date, end_date = parse_dates(start_date, end_date)
      block_rooms = room_numbers.map { |number| find_room_by_number(number) }
      validate_block(block_rooms, start_date, end_date)
      new_block = Hotel::Block.new(rooms: block_rooms, start_date: start_date, end_date: end_date, discount_rate: discount_rate)
      @blocks.push(new_block)
      return new_block
    end

    def reserve_from_block(block, room_number)
      room = find_room_by_number(room_number)
      block.book_room(room)
      new_reservation = Hotel::Reservation.new(room: room, start_date: block.start_date, end_date: block.end_date)
      @reservations.push(new_reservation)
      return new_reservation
    end

    #room methods
    def list_available_rooms(start_date, end_date)
      start_date, end_date = parse_dates(start_date, end_date)
      available_rooms = @rooms
      reservations.each do |reservation|
        if reservation.overlap?(start_date, end_date)
          available_rooms.delete(reservation.room)
        end
      end
      blocks.each do |block|
        if block.overlap?(start_date, end_date)
          block.rooms.each do |room|
            available_rooms.delete(room)
          end
        end
      end
      return available_rooms
    end

    def find_room_by_number(num)
      @rooms.each do |room|
        return room if room.room_number == num
      end
    end

    private

    def validate_block(rooms, start_date, end_date)
      available_rooms = list_available_rooms(start_date, end_date)
      unless rooms.all? { |room| available_rooms.include?(room) }
        raise ArgumentError, "All rooms for block must be available."
      end
    end

    def parse_dates(start_date, end_date)
      start_date = Date.parse(start_date) if start_date.is_a? String
      end_date = Date.parse(end_date) if end_date.is_a? String
      validate_dates(start_date, end_date)
      return start_date, end_date
    end

    def validate_dates(start_date, end_date)
      unless end_date > start_date
        raise ArgumentError, "End date must be after start date"
      end
    end
  end
end
