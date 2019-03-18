require_relative "room"
require_relative "reservation"
require_relative "block"

module HotelSystem
  class Hotel
    attr_reader :all_rooms
    attr_accessor :all_reservations, :all_blocks

    def initialize
      @all_reservations = []
      @all_rooms = []
      @all_blocks = []
      generate_rooms(20)
    end

    def generate_rooms(number_of_rooms)
      number_of_rooms.times do |i|
        @all_rooms << Room.new(number: i + 1)
      end
    end

    def see_reservations_by_date(date)
      this_dates_reservations = []
      @all_reservations.each do |reservation|
        this_dates_reservations << reservation if reservation.start_date == date
      end
      return this_dates_reservations
    end

    def see_available_rooms_by_date(possible_start_date, possible_end_date)
      these_dates_available_rooms = []
      @all_rooms.each do |room|
        these_dates_available_rooms << room if room.date_available?(possible_start_date, possible_end_date)
      end
      return these_dates_available_rooms
    end

    def reserve_room(room, start_date, end_date, guest)
      if room.date_available?(start_date, end_date)
        available_room = room
      else
        available_room = room_available?(start_date, end_date)
      end

      if !available_room
        raise ArgumentError, "There are no available rooms at this time. Please try again later."
      else
        reservation = HotelSystem::Reservation.new(room: available_room, start_date: start_date, end_date: end_date, guest: guest)
        available_room.reservations << reservation
        @all_reservations << reservation
      end
    end

    def room_available?(new_start_date, new_end_date)
      @all_rooms.each do |room|
        return room if room.date_available?(new_start_date, new_end_date)
      end
      return false
    end

    def hold_block(start_date, end_date, room_collection)
      room_collection.each do |room|
        raise ArgumentError, "Room #{room.number} is already in a block" if room.block_id != nil
      end

      block = HotelSystem::Block.new(start_date: start_date, end_date: end_date, room_collection: room_collection)

      room_collection.each do |room|
        room.block_id = block.id
        discount_price = room.price - (room.price * block.discount_rate)
        room.price = discount_price
      end

      @all_blocks << block
    end

    def reserve_block_room(start_date, end_date, room, block_id, guest)
      desired_block = @all_blocks.detect { |block| block.id == block_id }

      if desired_block == nil
        raise ArgumentError, "The block entered does not exist or it does not have any rooms available for reseervation"
      elsif desired_block.room_still_available?
        reservation = HotelSystem::Reservation.new(room: room, start_date: start_date, end_date: end_date, guest: guest)
        room.reservations << reservation
        @all_reservations << reservation
        desired_block.reservations << reservation
        reservation.room.block_id = nil
        reservation.room.price = 200
      end
    end
  end
end
