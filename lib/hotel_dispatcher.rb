require 'date'

require_relative 'room'
require_relative 'reservation'
require_relative 'block'
require_relative 'date_range'

module Hotel
  class HotelDispatcher
    attr_accessor :rooms, :reservations, :blocks
    def initialize
      @rooms = Hotel::Room.list_all_rooms
      @reservations = []
      @blocks = Hash.new(0)
    end

    def reserve(start_date, end_date)
      available_rooms = find_available_room(start_date, end_date)
      raise ArgumentError.new("Room is not available") if available_rooms.empty?
      new_room = available_rooms.take(1)[0]
      
      new_reservation = Hotel::Reservation.new(
        start_date: start_date,
        end_date: end_date,
        room: new_room
      )
      @reservations << new_reservation
      new_reservation
    end

    def add_block(start_date, end_date, room_nums, discounted_rate, access_code)
      rooms = room_nums.map do |room_num|
        self.find_room(room_num)
      end
      
      rooms.each do |room|
        if list_reserved_rooms(start_date, end_date).include?(room)
          raise ArgumentError.new("Room #{room.room_num} has already been reserved")
        elsif list_block_rooms(start_date, end_date).include?(room)
          raise ArgumentError.new("Room#{room.room_num} has already been added to a block")
        end
      end

      new_block = Hotel::Block.new(
        start_date: start_date, 
        end_date: end_date,
        rooms: rooms,
        discounted_rate: discounted_rate
      )
      raise ArgumentError.new("Access code is already taken, please try with a new one.") if @blocks.keys.include?(access_code)
      @blocks[access_code] = new_block
    end

    def reserve_from_block(room_num, access_code)
      raise ArgumentError.new("Access code #{access_code} is invalid") if !(@blocks.keys.include?(access_code))
      raise ArgumentError.new("This block room has already been reserved.") if list_block_reserved_rooms(access_code).include?(room_num)
      
      block = @blocks[access_code]
      room = block.rooms.find { |room| room.room_num == room_num }
      raise ArgumentError.new("Room #{room_num} is not available in this block") if room == nil

      new_reservation = Hotel::Reservation.new(
        start_date: block.date_range.start_date.to_s,
        end_date: block.date_range.end_date.to_s,
        room: room
      )
      block.block_reservations << new_reservation
      @reservations << new_reservation
      new_reservation
    end

    def find_reservation(date)
      reservation_by_date = []
      @reservations.each do |r|
        if r.date_range.is_included?(date)
          reservation_by_date << r
        end
      end
      return reservation_by_date
    end 

    def list_reserved_rooms(start_date, end_date)
      reserved_rooms = [] 
      @reservations.each do |r|
        if r.date_range.is_overlapped?(start_date, end_date)
          reserved_rooms << r.room
        end
      end
      return reserved_rooms
    end

    def list_block_rooms(start_date, end_date)
      block_rooms = [] 
      @blocks.values.each do |b|
        if b.date_range.is_overlapped?(start_date, end_date)
          b.rooms.each do |room|
            block_rooms << room
          end
        end
      end
      return block_rooms
    end

    def list_block_reserved_rooms(access_code)
      reserved_block_rooms = []
      @blocks[access_code].block_reservations.each do |reservation| 
        reserved_block_rooms << reservation.room.room_num
      end
      return reserved_block_rooms
    end

    def block_room_available?(access_code)
      #check whether a given block has any rooms available
      block_rooms  = @blocks[access_code].rooms.map { |room| room.room_num}
      available_block_rooms = []
      block_rooms.each do |block_room|
        if !(list_block_reserved_rooms(access_code).include?(block_room))
          available_block_rooms << block_room
        end
      end
      return available_block_rooms
    end

    def find_available_room(start_date, end_date)
      available_rooms = []
      @rooms.each do |room|
        if !(list_reserved_rooms(start_date, end_date).include?(room)) && !(list_block_rooms(start_date, end_date).include?(room))
          available_rooms << room
        end
      end
      return available_rooms
    end

    def find_room(room_num)
      return @rooms.find { |room| room.room_num == room_num }
    end
  end
end